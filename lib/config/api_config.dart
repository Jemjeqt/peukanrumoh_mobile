/// Konfigurasi API untuk koneksi ke Laravel Backend
class ApiConfig {
  // ===========================================
  // BASE URL - Production Server
  // ===========================================
  static const String baseUrl =
      'https://peukanrumoh.sisteminformasikotacerdas.id/api';

  // LOCAL DEVELOPMENT - Uncomment jika testing lokal:
  // static const String baseUrl = 'http://127.0.0.1:8000/api'; // Chrome/Web
  // static const String baseUrl = 'http://10.0.2.2:8000/api'; // Emulator Android
  // static const String baseUrl = 'http://192.168.x.x:8000/api'; // Device via WiFi

  // Timeout settings
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Auth Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String logout = '/logout';
  static const String user = '/user';

  // Product Endpoints
  static const String products = '/products';

  // Cart Endpoints
  static const String cart = '/cart';
  static String cartAdd = '/cart/add';
  static String cartUpdate(int id) => '/cart/$id';
  static String cartRemove(int id) => '/cart/$id';

  // Order Endpoints
  static const String orders = '/orders';
  static String orderDetail(int id) => '/orders/$id';
  static String orderPayment(int id) => '/orders/$id/pay';
}
