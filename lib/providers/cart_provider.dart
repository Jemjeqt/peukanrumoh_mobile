import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../services/api_service.dart';

class CartProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<CartItem> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  int get itemCount => _items.length;
  
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  // Fetch cart
  Future<void> fetchCart() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.getCart();
      print('DEBUG: Fetch cart response: $response');
      
      if (response['success'] == true) {
        // Print authenticated user ID from server
        final authUserId = response['data']['auth_user_id'];
        print('DEBUG SERVER AUTH: auth_user_id from server = $authUserId');
        
        final List<dynamic> itemsJson = response['data']['items'];
        _items = itemsJson.map((json) => CartItem.fromJson(json)).toList();
        // Debug: print each item's user_id and compare
        for (var item in _items) {
          print('DEBUG: Cart item ID: ${item.id}, User ID: ${item.userId}, Product: ${item.product?.name}');
          if (item.userId != authUserId) {
            print('WARNING: Cart item user_id ${item.userId} does NOT match auth_user_id $authUserId!');
          }
        }
      } else {
        _errorMessage = response['message'];
      }
    } catch (e) {
      _errorMessage = 'Error fetching cart: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add to cart
  Future<bool> addToCart({required int productId, required int quantity}) async {
    try {
      final response = await _apiService.addToCart(
        productId: productId,
        quantity: quantity,
      );

      if (response['success'] == true) {
        await fetchCart(); // Refresh cart
        return true;
      } else {
        _errorMessage = response['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error adding to cart: $e';
      notifyListeners();
      return false;
    }
  }

  // Update cart item
  Future<bool> updateCartItem({required int cartId, required int quantity}) async {
    print('DEBUG: Updating cart item - cartId: $cartId, quantity: $quantity');
    try {
      final response = await _apiService.updateCartItem(
        cartId: cartId,
        quantity: quantity,
      );
      print('DEBUG: Update response: $response');

      if (response['success'] == true) {
        await fetchCart(); // Refresh cart
        return true;
      } else {
        _errorMessage = response['message'];
        print('DEBUG: Update failed - ${response['message']}');
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error updating cart: $e';
      print('DEBUG: Update exception - $e');
      notifyListeners();
      return false;
    }
  }

  // Remove from cart
  Future<bool> removeFromCart(int cartId) async {
    try {
      final response = await _apiService.removeFromCart(cartId);

      if (response['success'] == true) {
        await fetchCart(); // Refresh cart
        return true;
      } else {
        _errorMessage = response['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error removing from cart: $e';
      notifyListeners();
      return false;
    }
  }

  // Clear cart
  Future<void> clearCart() async {
    try {
      await _apiService.clearCart();
      _items = [];
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error clearing cart: $e';
      notifyListeners();
    }
  }
}
