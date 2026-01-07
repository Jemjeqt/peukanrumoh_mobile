import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  // Register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.register(
        name: name,
        email: email,
        password: password,
      );

      if (response['token'] != null) {
        await _apiService.saveToken(response['token']);
        _user = User.fromJson(response['user']);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Registration failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Login
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      if (response['token'] != null) {
        await _apiService.saveToken(response['token']);
        _user = User.fromJson(response['user']);
        print('DEBUG AUTH: Login successful! User ID: ${_user?.id}, Name: ${_user?.name}, Email: ${_user?.email}');
        print('DEBUG AUTH: Token saved: ${response['token'].toString().substring(0, 20)}...');
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.logout();
    } catch (e) {
      // Ignore error, just clear local data
    }
    _user = null;
    notifyListeners();
  }

  // Update user locally (for immediate UI refresh)
  void updateUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // Update user from json (for API responses)
  void updateUserFromJson(Map<String, dynamic> userData) {
    _user = User.fromJson(userData);
    notifyListeners();
  }

  // Check if user is logged in
  Future<bool> checkAuth() async {
    final token = await _apiService.getToken();
    if (token == null) return false;

    try {
      final response = await _apiService.getUser();
      // API returns { success: true, user: {...} }
      final userData = response['user'] ?? response;
      if (userData != null && userData['id'] != null) {
        _user = User.fromJson(userData);
        notifyListeners();
        return true;
      }
    } catch (e) {
      await _apiService.removeToken();
    }
    
    return false;
  }
}
