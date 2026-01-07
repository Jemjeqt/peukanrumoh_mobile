import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Fetch all products
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getProducts();
      
      if (response['success'] == true && response['data'] != null) {
        // Laravel pagination returns {data: {data: [...], current_page, ...}}
        final data = response['data'];
        List<dynamic> productsJson;
        
        if (data is List) {
          // Direct array response
          productsJson = data;
        } else if (data is Map && data['data'] != null) {
          // Paginated response: {data: [...], current_page, ...}
          productsJson = data['data'];
        } else {
          productsJson = [];
        }
        
        _products = productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        _errorMessage = response['message'] ?? 'Failed to load products';
      }
    } catch (e) {
      _errorMessage = 'Error fetching products: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Get product by ID
  Future<Product?> getProduct(int id) async {
    try {
      final response = await _apiService.getProduct(id);
      
      if (response['data'] != null) {
        return Product.fromJson(response['data']);
      }
    } catch (e) {
      _errorMessage = 'Error fetching product: $e';
      notifyListeners();
    }
    return null;
  }
}
