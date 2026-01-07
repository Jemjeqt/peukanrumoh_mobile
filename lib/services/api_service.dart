import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  
  late Dio _dio;
  
  // Using ApiConfig for centralized URL management
  static String get baseUrl => ApiConfig.baseUrl;

  ApiService._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptor for logging and token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if exists
        final token = await getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          print('DEBUG TOKEN: Using token: ${token.substring(0, 20)}...');
        } else {
          print('DEBUG TOKEN: No token available!');
        }
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
        print('ERROR MESSAGE: ${e.message}');
        return handler.next(e);
      },
    ));
  }

  // Token management
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // ============================================
  // AUTH ENDPOINTS
  // ============================================

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'role': 'pembeli', // Always pembeli for mobile app
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _dio.post('/logout');
      await removeToken();
      return response.data;
    } on DioException catch (e) {
      await removeToken(); // Clear token anyway
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getUser() async {
    try {
      final response = await _dio.get('/user');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String name,
    String? phone,
    String? address,
  }) async {
    try {
      final response = await _dio.put('/user/profile', data: {
        'name': name,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (address != null && address.isNotEmpty) 'address': address,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> uploadAvatarBytes({
    required List<int> bytes,
    required String fileName,
  }) async {
    try {
      final formData = FormData.fromMap({
        'avatar': MultipartFile.fromBytes(bytes, filename: fileName),
      });
      
      final response = await _dio.post('/user/avatar', data: formData);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // ============================================
  // PRODUCT ENDPOINTS
  // ============================================

  Future<Map<String, dynamic>> getProducts({String? search, String? category}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null && search.isNotEmpty) queryParams['search'] = search;
      if (category != null && category.isNotEmpty) queryParams['category'] = category;
      
      final response = await _dio.get('/products', queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getProduct(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // ============================================
  // CART ENDPOINTS
  // ============================================

  Future<Map<String, dynamic>> getCart() async {
    try {
      final response = await _dio.get('/cart');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> addToCart({
    required int productId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.post('/cart', data: {
        'product_id': productId,
        'quantity': quantity,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> updateCartItem({
    required int cartId,
    required int quantity,
  }) async {
    try {
      final response = await _dio.put('/cart/$cartId', data: {
        'quantity': quantity,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> removeFromCart(int cartId) async {
    try {
      final response = await _dio.delete('/cart/$cartId');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> clearCart() async {
    try {
      final response = await _dio.delete('/cart');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // ============================================
  // ORDER ENDPOINTS
  // ============================================

  Future<Map<String, dynamic>> getOrders() async {
    try {
      final response = await _dio.get('/orders');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> getOrder(int id) async {
    try {
      final response = await _dio.get('/orders/$id');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createOrder({
    required String shippingAddress,
    required String phone,
    required String paymentMethod,
    String? notes,
  }) async {
    try {
      final response = await _dio.post('/orders', data: {
        'shipping_address': shippingAddress,
        'phone': phone,
        'payment_method': paymentMethod,
        'notes': notes,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> confirmPayment(int orderId) async {
    try {
      final response = await _dio.post('/orders/$orderId/payment');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> confirmDelivery(int orderId) async {
    try {
      final response = await _dio.post('/orders/$orderId/confirm-delivery');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> submitReview({
    required int orderId,
    required int productId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await _dio.post('/orders/$orderId/review', data: {
        'product_id': productId,
        'rating': rating,
        'comment': comment,
      });
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> createReturn({
    required int orderId,
    required String reason,
    required String type, // 'replacement' or 'refund'
    Uint8List? evidenceBytes, // Image bytes for web compatibility
    String? evidenceFileName,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'reason': reason,
        'type': type,
      });

      // Add evidence file if provided (using bytes for web compatibility)
      if (evidenceBytes != null) {
        // Determine content type from filename
        String contentType = 'image/jpeg';
        if (evidenceFileName != null) {
          if (evidenceFileName.toLowerCase().endsWith('.png')) {
            contentType = 'image/png';
          } else if (evidenceFileName.toLowerCase().endsWith('.webp')) {
            contentType = 'image/webp';
          }
        }
        
        formData.files.add(MapEntry(
          'evidence',
          MultipartFile.fromBytes(
            evidenceBytes,
            filename: evidenceFileName ?? 'evidence.jpg',
            contentType: DioMediaType.parse(contentType),
          ),
        ));
      }

      final response = await _dio.post('/orders/$orderId/return', data: formData);
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> confirmReplacement(int orderId) async {
    try {
      final response = await _dio.post('/orders/$orderId/confirm-replacement');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Future<Map<String, dynamic>> confirmRefund(int orderId) async {
    try {
      final response = await _dio.post('/orders/$orderId/confirm-refund');
      return response.data;
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // ============================================
  // ERROR HANDLER
  // ============================================

  Map<String, dynamic> _handleError(DioException e) {
    String message = 'Terjadi kesalahan';
    
    if (e.response != null) {
      // Server responded with error
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        message = data['message'];
      } else {
        switch (e.response?.statusCode) {
          case 400:
            message = 'Permintaan tidak valid';
            break;
          case 401:
            message = 'Sesi telah berakhir, silakan login kembali';
            break;
          case 403:
            message = 'Anda tidak memiliki akses';
            break;
          case 404:
            message = 'Data tidak ditemukan';
            break;
          case 422:
            message = 'Data tidak valid';
            break;
          case 500:
            message = 'Terjadi kesalahan pada server';
            break;
          default:
            message = 'Error: ${e.response?.statusCode}';
        }
      }
    } else if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Koneksi timeout, periksa jaringan Anda';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      message = 'Server tidak merespon';
    } else if (e.type == DioExceptionType.connectionError) {
      message = 'Tidak dapat terhubung ke server';
    } else {
      message = e.message ?? 'Terjadi kesalahan tidak diketahui';
    }

    return {
      'success': false,
      'message': message,
    };
  }
}
