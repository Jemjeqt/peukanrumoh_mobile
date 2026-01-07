# LAPORAN DESAIN DAN PEMROGRAMAN PERANGKAT BERGERAK (DPPB)

# APLIKASI MOBILE E-COMMERCE PEUKAN RUMOH

---

## 1. Pendahuluan

### 1.1 Latar Belakang

Seiring dengan perkembangan teknologi mobile dan meningkatnya penggunaan smartphone, kebutuhan akan aplikasi mobile yang dapat melengkapi platform web menjadi sangat penting. Sistem e-commerce Peukan Rumoh yang telah dikembangkan menggunakan Laravel sebagai backend memerlukan aplikasi mobile yang dapat memberikan pengalaman berbelanja yang lebih praktis dan personal bagi pengguna.

Aplikasi mobile **Peukan Rumoh** dikembangkan menggunakan **Flutter**, sebuah framework cross-platform dari Google yang memungkinkan pengembangan aplikasi untuk Android, iOS, dan Web dari satu codebase. Aplikasi ini dirancang khusus untuk **role Pembeli (Customer)**, sementara role Admin, Pedagang, dan Kurir tetap menggunakan dashboard web Laravel yang lebih kompleks dan memerlukan layar lebih besar.

Dengan aplikasi mobile ini, pembeli dapat dengan mudah menelusuri produk, menambahkan ke keranjang, melakukan checkout, dan melacak pesanan mereka dari mana saja dan kapan saja melalui smartphone.

### 1.2 Rumusan Masalah

Berdasarkan latar belakang di atas, rumusan masalah dalam pengembangan aplikasi mobile ini adalah:

1. Bagaimana mengimplementasikan aplikasi mobile cross-platform yang dapat terintegrasi dengan backend Laravel yang sudah ada?

2. Bagaimana menerapkan arsitektur yang baik dan state management yang efektif pada aplikasi Flutter?

3. Bagaimana mengimplementasikan komunikasi RESTful API antara aplikasi mobile dengan backend server?

4. Bagaimana menciptakan UI/UX yang modern, responsif, dan user-friendly untuk pengalaman belanja mobile?

5. Bagaimana menangani autentikasi berbasis token (JWT) dan menyimpan data secara lokal pada aplikasi mobile?

### 1.3 Tujuan

Tujuan dari pengembangan aplikasi mobile Peukan Rumoh adalah:

| No | Tujuan | Deskripsi |
|----|--------|-----------|
| 1 | **Aksesibilitas Mobile** | Memberikan akses berbelanja melalui smartphone kepada pembeli kapan saja dan di mana saja |
| 2 | **Cross-Platform** | Mengembangkan satu codebase yang dapat berjalan di Android, iOS, dan Web |
| 3 | **Integrasi Backend** | Mengintegrasikan aplikasi dengan REST API Laravel untuk data real-time |
| 4 | **Modern UI/UX** | Menciptakan antarmuka yang modern dengan Material Design 3 dan animasi smooth |
| 5 | **State Management** | Menerapkan pengelolaan state yang efisien menggunakan Provider pattern |

### 1.4 Manfaat

**Manfaat bagi Pembeli:**
- Kemudahan berbelanja langsung dari smartphone
- Notifikasi dan tracking pesanan yang mudah diakses
- Pengalaman pengguna yang lebih cepat dan responsif
- Dapat berbelanja dalam kondisi offline (cached data)

**Manfaat bagi Platform:**
- Jangkauan pengguna yang lebih luas melalui mobile app
- Engagement pengguna yang lebih tinggi
- Pengembangan efisien dengan single codebase (Flutter)

---

## 2. Gambaran Sistem

### 2.1 Deskripsi Umum

**Peukan Rumoh Mobile** adalah aplikasi companion dari sistem web Laravel yang dibuat khusus untuk role Pembeli. Aplikasi ini memungkinkan pembeli untuk melakukan aktivitas belanja lengkap mulai dari browsing produk hingga tracking pesanan.

### 2.2 Ruang Lingkup Sistem

```
+-------------------------------------------------------------------+
|                    PEUKAN RUMOH MOBILE APP                        |
|                      (Khusus Role Pembeli)                        |
+-------------------------------------------------------------------+
|                                                                   |
|  +-------------+  +-------------+  +-------------+  +-----------+ |
|  |    AUTH     |  |    SHOP     |  |    CART     |  | CHECKOUT  | |
|  +-------------+  +-------------+  +-------------+  +-----------+ |
|  | - Register  |  | - Browse    |  | - View Cart |  | - Alamat  | |
|  | - Login     |  |   Produk    |  | - Update    |  | - Payment | |
|  | - Logout    |  | - Kategori  |  |   Quantity  |  | - Confirm | |
|  | - Forgot    |  | - Detail    |  | - Remove    |  |           | |
|  |   Password  |  |   Produk    |  |   Item      |  |           | |
|  +-------------+  +-------------+  +-------------+  +-----------+ |
|                                                                   |
|  +-------------+  +-------------+                                 |
|  |   ORDERS    |  |   PROFILE   |                                 |
|  +-------------+  +-------------+                                 |
|  | - Riwayat   |  | - Edit      |                                 |
|  |   Pesanan   |  |   Profile   |                                 |
|  | - Detail    |  | - Change    |                                 |
|  |   Order     |  |   Password  |                                 |
|  | - Tracking  |  | - Alamat    |                                 |
|  |   Status    |  | - Theme     |                                 |
|  +-------------+  +-------------+                                 |
|                                                                   |
+-------------------------------------------------------------------+
```

### 2.3 Perbandingan dengan Aplikasi Web

| Aspek | Aplikasi Web (Laravel) | Aplikasi Mobile (Flutter) |
|-------|------------------------|---------------------------|
| **Target User** | Admin, Pedagang, Kurir, Pembeli | Pembeli saja |
| **Platform** | Browser (Desktop/Mobile) | Android, iOS, Web |
| **Framework** | Laravel 11 + Blade | Flutter 3.x + Dart |
| **Database** | MySQL langsung | Via REST API |
| **State** | Server-side (Session) | Client-side (Provider) |
| **Auth** | Laravel Auth + Session | JWT Token + SharedPreferences |
| **UI** | Blade + Vanilla CSS | Material Design 3 |

---

## 3. Arsitektur Sistem

### 3.1 Arsitektur Aplikasi Flutter

Aplikasi menggunakan arsitektur **MVC-like** dengan Provider Pattern:

```
+-----------------------------------------------------------------------+
|                    FLUTTER APP ARCHITECTURE                            |
+-----------------------------------------------------------------------+
|                                                                       |
|  +-------------+         +-------------+         +-------------+      |
|  |    VIEW     |<------->|  PROVIDER   |<------->|    MODEL    |      |
|  |  (Screens)  |         | (Controller)|         |   (Data)    |      |
|  +-------------+         +-------------+         +-------------+      |
|  | - Splash    |         | - AuthProv  |         | - User      |      |
|  | - Login     |         | - ProductPr |         | - Product   |      |
|  | - Register  |         | - CartProv  |         | - CartItem  |      |
|  | - Home      |         | - ThemeProv |         | - Order     |      |
|  | - Detail    |         |             |         | - OrderItem |      |
|  | - Cart      |         +------+------+         +------+------+      |
|  | - Checkout  |                |                       |             |
|  | - Orders    |                v                       v             |
|  | - Profile   |         +-------------+         +-------------+      |
|  +-------------+         | API SERVICE |         | API CONFIG  |      |
|                          |    (Dio)    |         |  Endpoints  |      |
|                          +------+------+         +-------------+      |
|                                 |                                     |
|                                 v                                     |
|                    +------------------------+                         |
|                    |     LARAVEL REST API   |                         |
|                    |   peukanrumoh.server   |                         |
|                    +------------------------+                         |
|                                                                       |
+-----------------------------------------------------------------------+
```

### 3.2 Teknologi yang Digunakan

| Komponen | Teknologi | Versi | Keterangan |
|----------|-----------|-------|------------|
| Framework | Flutter | 3.10+ | Cross-platform UI Framework |
| Language | Dart | 3.10+ | Programming Language |
| State Management | Provider | 6.1.1 | ChangeNotifier Pattern |
| HTTP Client | Dio | 5.4.0 | Advanced HTTP Client dengan Interceptor |
| Local Storage | SharedPreferences | 2.2.2 | Menyimpan Token & Settings |
| Image Loading | cached_network_image | 3.3.1 | Image Caching |
| Loading Effect | Shimmer | 3.0.0 | Skeleton Loading Animation |
| Image Picker | image_picker | 1.0.7 | Akses Camera/Gallery |
| Design System | Material 3 | - | Google Material Design |

### 3.3 Struktur Folder Project

```
lib/
+-- config/                          # Konfigurasi
|   +-- api_config.dart              # Base URL & Endpoints
|
+-- models/                          # Data Models (4 files)
|   +-- user.dart                    # Model User
|   +-- product.dart                 # Model Product
|   +-- cart_item.dart               # Model CartItem
|   +-- order.dart                   # Model Order & OrderItem
|
+-- providers/                       # State Management (4 files)
|   +-- auth_provider.dart           # Auth state & methods
|   +-- product_provider.dart        # Product state & methods
|   +-- cart_provider.dart           # Cart state & methods
|   +-- theme_provider.dart          # Theme state (dark/light)
|
+-- screens/                         # UI Screens (12 files)
|   +-- splash_screen.dart           # Splash & Auto-login
|   +-- main_screen.dart             # Bottom Navigation Host
|   +-- auth/
|   |   +-- login_screen.dart
|   |   +-- register_screen.dart
|   +-- home/
|   |   +-- home_screen.dart
|   |   +-- product_detail_screen.dart
|   +-- cart/
|   |   +-- cart_screen.dart
|   +-- checkout/
|   |   +-- checkout_screen.dart
|   |   +-- payment_screen.dart
|   +-- orders/
|   |   +-- orders_screen.dart
|   |   +-- order_success_screen.dart
|   +-- settings/
|       +-- edit_profile_screen.dart
|       +-- change_password_screen.dart
|       +-- shipping_address_screen.dart
|
+-- services/                        # API Services (1 file)
|   +-- api_service.dart             # Dio HTTP Client Singleton
|
+-- widgets/                         # Reusable Widgets (3 files)
|   +-- custom_widgets.dart          # CustomTextField, CustomButton
|   +-- product_card.dart            # Product card component
|   +-- shimmer_loading.dart         # Loading skeleton
|
+-- main.dart                        # App Entry Point + Themes
```

### 3.4 Pembagian Tugas per Anggota (PIC)

| Anggota | Role PIC | Komponen yang Dikerjakan |
|---------|----------|--------------------------|
| **Nashrullah Al Himni** | Pengembang Inti & Autentikasi | `main.dart`, `api_service.dart`, `auth_provider.dart`, Screens auth/, Models, API Config |
| **Azhar Khairu Hafidz** | Pengembang Toko & Keranjang | `product_provider.dart`, `cart_provider.dart`, Screens home/, cart/, Widgets |
| **Aziz Faturrahman** | Pengembang Pesanan & Profil | Screens checkout/, orders/, settings/, `theme_provider.dart` |

---

## 4. Implementasi Sistem dan Analisis

### 4.1 Implementasi Models

#### 4.1.1 Ringkasan Model

| No | Model | Properties | Methods | Deskripsi |
|----|-------|:----------:|:-------:|-----------|
| 1 | `User` | 7 | 4 | Data pengguna (id, name, email, role, phone, address, avatar) |
| 2 | `Product` | 9 | 2 | Data produk (id, name, description, price, stock, image, category, userId, isActive) |
| 3 | `CartItem` | 5 | 2 | Item keranjang (id, productId, productName, price, quantity) |
| 4 | `Order` | 15 | 5 | Data pesanan dengan items dan return status |
| 5 | `OrderItem` | 7 | 2 | Detail item dalam pesanan |
| 6 | `ProductReturn` | 4 | 2 | Data return (id, status, type, reason) dengan statusLabel getter |
| **Total** | **6 Model** | **47** | **17** | |

#### 4.1.2 Contoh Implementasi Model: User

```dart
class User {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String? phone;
  final String? address;
  final String? avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.role,
    this.phone,
    this.address,
    this.avatar,
  });

  // Getter untuk avatar URL lengkap
  String? get avatarUrl {
    if (avatar == null || avatar!.isEmpty) return null;
    if (avatar!.startsWith('http')) return avatar;
    return '${ApiConfig.baseUrl}/storage/$avatar';
  }

  // Factory constructor untuk parsing JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'],
      phone: json['phone'],
      address: json['address'],
      avatar: json['avatar'],
    );
  }

  // Konversi ke JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
      'avatar': avatar,
    };
  }

  // Copy dengan modifikasi
  User copyWith({String? name, String? phone, String? address, String? avatar}) {
    return User(
      id: id,
      name: name ?? this.name,
      email: email,
      role: role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }
}
```

### 4.2 Implementasi Providers (State Management)

#### 4.2.1 Ringkasan Providers

| No | Provider | State Properties | Methods | Fungsi Utama |
|----|----------|:----------------:|:-------:|--------------|
| 1 | `AuthProvider` | 4 | 8 | Login, Register, Logout, Token Management |
| 2 | `ProductProvider` | 3 | 3 | Fetch Products, Filter by Category |
| 3 | `CartProvider` | 3 | 6 | Add, Update, Remove, Clear Cart |
| 4 | `ThemeProvider` | 1 | 2 | Toggle Dark/Light Mode |
| **Total** | **4 Provider** | **11** | **19** | |

#### 4.2.2 Contoh Implementasi: AuthProvider

```dart
class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;

  // Login Method
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _apiService.login(email, password);
      if (response['success'] == true) {
        _user = User.fromJson(response['user']);
        _isAuthenticated = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response['message'] ?? 'Login gagal';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Logout Method
  Future<void> logout() async {
    await _apiService.logout();
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  // Check Authentication Status
  Future<bool> checkAuth() async {
    try {
      final token = await _apiService.getToken();
      if (token != null) {
        final response = await _apiService.getUser();
        if (response['success'] == true) {
          _user = User.fromJson(response['user']);
          _isAuthenticated = true;
          notifyListeners();
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
```

#### 4.2.3 Contoh Implementasi: CartProvider

```dart
class CartProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<CartItem> _items = [];
  bool _isLoading = false;

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _items.fold(0.0, (sum, item) => sum + item.subtotal);

  // Fetch Cart dari API
  Future<void> fetchCart() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.getCart();
      if (response['success'] == true) {
        _items = (response['cart'] as List)
            .map((item) => CartItem.fromJson(item))
            .toList();
      }
    } catch (e) {
      print('Error fetching cart: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add to Cart
  Future<bool> addToCart(int productId, int quantity) async {
    try {
      final response = await _apiService.addToCart(productId, quantity);
      if (response['success'] == true) {
        await fetchCart();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Update Quantity
  Future<void> updateQuantity(int cartId, int quantity) async {
    try {
      await _apiService.updateCart(cartId, quantity);
      await fetchCart();
    } catch (e) {
      print('Error updating cart: $e');
    }
  }

  // Remove from Cart
  Future<void> removeFromCart(int cartId) async {
    try {
      await _apiService.removeFromCart(cartId);
      _items.removeWhere((item) => item.id == cartId);
      notifyListeners();
    } catch (e) {
      print('Error removing from cart: $e');
    }
  }

  // Clear Cart
  void clearCart() {
    _items = [];
    notifyListeners();
  }
}
```

### 4.3 Implementasi API Service

#### 4.3.1 Konfigurasi API

```dart
// lib/config/api_config.dart
class ApiConfig {
  // Base URL untuk production
  static const String baseUrl = 'https://peukanrumoh.sisteminformasikotacerdas.id';
  
  // Endpoints
  static const String login = '/api/login';
  static const String register = '/api/register';
  static const String logout = '/api/logout';
  static const String user = '/api/user';
  static const String updateProfile = '/api/user/update';
  static const String changePassword = '/api/user/change-password';
  static const String products = '/api/products';
  static const String cart = '/api/cart';
  static const String orders = '/api/orders';
  
  // Timeout settings
  static const int connectTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
}
```

#### 4.3.2 API Service dengan Dio

```dart
class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: Duration(milliseconds: ApiConfig.connectTimeout),
    receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  final _storage = SharedPreferences.getInstance();
  static const String _tokenKey = 'auth_token';

  // Interceptor untuk menambahkan token
  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          // Token expired, clear and redirect to login
          clearToken();
        }
        return handler.next(error);
      },
    ));
  }

  // Authentication
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(ApiConfig.login, data: {
        'email': email,
        'password': password,
      });
      
      if (response.data['token'] != null) {
        await saveToken(response.data['token']);
      }
      
      return {'success': true, 'user': response.data['user']};
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Products
  Future<Map<String, dynamic>> getProducts({String? category}) async {
    try {
      final response = await _dio.get(ApiConfig.products, queryParameters: {
        if (category != null) 'category': category,
      });
      return {'success': true, 'products': response.data['products']};
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  // Cart Operations
  Future<Map<String, dynamic>> getCart() async {
    final response = await _dio.get(ApiConfig.cart);
    return {'success': true, 'cart': response.data['cart']};
  }

  Future<Map<String, dynamic>> addToCart(int productId, int quantity) async {
    final response = await _dio.post(ApiConfig.cart, data: {
      'product_id': productId,
      'quantity': quantity,
    });
    return {'success': true};
  }

  // Orders
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    final response = await _dio.post(ApiConfig.orders, data: orderData);
    return {'success': true, 'order': response.data['order']};
  }

  // Error Handler
  Map<String, dynamic> _handleError(DioException e) {
    String message = 'Terjadi kesalahan';
    
    if (e.type == DioExceptionType.connectionTimeout) {
      message = 'Koneksi timeout. Periksa jaringan Anda.';
    } else if (e.type == DioExceptionType.connectionError) {
      message = 'Tidak dapat terhubung ke server.';
    } else if (e.response != null) {
      message = e.response?.data['message'] ?? 'Error: ${e.response?.statusCode}';
    }
    
    return {'success': false, 'message': message};
  }
}
```

### 4.4 Implementasi Screens

#### 4.4.1 Ringkasan Screens

| No | Screen | Widgets | Fungsi |
|----|--------|:-------:|--------|
| 1 | `SplashScreen` | 5 | Auto-login check, animasi logo |
| 2 | `LoginScreen` | 8 | Form login dengan validasi |
| 3 | `RegisterScreen` | 10 | Form registrasi dengan validasi |
| 4 | `MainScreen` | 4 | Bottom navigation host |
| 5 | `HomeScreen` | 12 | Grid produk, kategori filter |
| 6 | `ProductDetailScreen` | 10 | Detail produk, add to cart |
| 7 | `CartScreen` | 8 | List item, quantity, checkout |
| 8 | `CheckoutScreen` | 12 | Form alamat, ringkasan order |
| 9 | `PaymentScreen` | 8 | Pilih metode pembayaran |
| 10 | `OrdersScreen` | 6 | List riwayat pesanan |
| 11 | `OrderSuccessScreen` | 5 | Konfirmasi order berhasil |
| 12 | `EditProfileScreen` | 8 | Form edit profile |
| 13 | `ChangePasswordScreen` | 6 | Form ganti password |
| 14 | `ShippingAddressScreen` | 5 | Kelola alamat |
| **Total** | **14 Screen** | **107** | |

#### 4.4.2 Main Entry Point dengan MultiProvider

```dart
// lib/main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Peukan Rumoh',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
```

### 4.5 Implementasi Theming

#### 4.5.1 Color Palette

```dart
class AppColors {
  // Primary Gradient Colors (Teal-Green)
  static const Color primaryStart = Color(0xFF11998E);
  static const Color primaryEnd = Color(0xFF38EF7D);
  static const Color primary = Color(0xFF11998E);
  
  // Accent Color (Orange - untuk logo "Rumoh")
  static const Color accent = Color(0xFFFF6F00);
  
  // Light Mode Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  
  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkCardBg = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  
  // Status Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  
  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryStart, primaryEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

### 4.6 Navigasi Aplikasi

#### 4.6.1 Bottom Navigation

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: _onTabTapped,
  type: BottomNavigationBarType.fixed,
  selectedItemColor: AppColors.primary,
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Badge(
        label: Text('$cartCount'),
        isLabelVisible: cartCount > 0,
        child: Icon(Icons.shopping_cart_outlined),
      ),
      activeIcon: Icon(Icons.shopping_cart),
      label: 'Keranjang',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: 'Pesanan',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ],
)
```

#### 4.6.2 Screen Navigation Flow

| From | To | Method | Trigger |
|------|-----|--------|---------|
| Splash | Login | pushReplacement | No token |
| Splash | Main | pushReplacement | Valid token |
| Login | Main | pushReplacement | Login success |
| Login | Register | push | Tap "Daftar" |
| Home | ProductDetail | push | Tap product |
| Cart | Checkout | push | Tap checkout |
| Checkout | Payment | push | Tap bayar |
| Payment | OrderSuccess | pushReplacement | Payment success |
| Profile | EditProfile | push | Tap menu |
| Profile | ChangePassword | push | Tap menu |

### 4.7 Fitur-Fitur Aplikasi

#### 4.7.1 Fitur Authentication

| No | Fitur | Deskripsi |
|----|-------|-----------|
| 1 | Splash Screen | Auto-check token dan redirect ke Login/Main |
| 2 | Login | Input email & password, validasi form |
| 3 | Register | Daftar akun baru sebagai pembeli |
| 4 | Logout | Hapus token lokal dan server |
| 5 | Remember Token | Token disimpan di SharedPreferences |

#### 4.7.2 Fitur Belanja

| No | Fitur | Deskripsi |
|----|-------|-----------|
| 1 | Browse Produk | Grid view dengan kategori filter |
| 2 | Detail Produk | Gambar besar, deskripsi, stok, add to cart |
| 3 | Keranjang | List item, update quantity, hapus item |
| 4 | Checkout | Form alamat, ringkasan pesanan, total |
| 5 | Payment | Pilih metode bayar (COD, Transfer, E-Wallet) |
| 6 | Order Success | Konfirmasi order berhasil dibuat |

#### 4.7.3 Fitur Order & Profile

| No | Fitur | Deskripsi |
|----|-------|-----------|
| 1 | Riwayat Pesanan | List semua order dengan status badge (termasuk status return) |
| 2 | Konfirmasi Diterima | Konfirmasi penerimaan pesanan (status: delivered → completed) |
| 3 | Ulasan Produk | Berikan rating (1-5 bintang) dan komentar untuk produk |
| 4 | Request Return | Ajukan pengembalian dengan upload foto bukti |
| 5 | Konfirmasi Pengganti | Konfirmasi penerimaan barang pengganti dari return |
| 6 | Konfirmasi Refund | Konfirmasi penerimaan dana pengembalian |
| 7 | Edit Profile | Ubah nama, telepon, alamat |
| 8 | Ganti Password | Form validasi password lama & baru |
| 9 | Alamat Pengiriman | Kelola alamat tersimpan |
| 10 | Dark Mode | Toggle tema gelap/terang |

### 4.8 Dependencies (pubspec.yaml)

```yaml
name: peukan_rumoh
description: Aplikasi Mobile E-Commerce Peukan Rumoh
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # HTTP & API
  dio: ^5.4.0
  
  # State Management  
  provider: ^6.1.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # UI Enhancement
  shimmer: ^3.0.0
  cached_network_image: ^3.3.1
  
  # Media
  image_picker: ^1.0.7

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

---

## 5. Deklarasi Penggunaan AI oleh Mahasiswa

Kami, anggota kelompok pengembang sistem Peukan Rumoh, menggunakan teknologi AI dalam proses pengembangan aplikasi ini sebagai berikut:

### 5.1 Tools AI yang Digunakan

| No | Tool AI | Kegunaan |
|----|---------|----------|
| 1 | GitHub Copilot | Code completion, saran implementasi Widget |
| 2 | ChatGPT / Claude | Konsultasi arsitektur Flutter, debugging, UI/UX design |

### 5.2 Batasan Penggunaan

1. **AI digunakan sebagai alat bantu**, bukan pengganti pemahaman konsep
2. **Penyesuaian dan modifikasi** dilakukan sesuai kebutuhan spesifik sistem
3. AI digunakan untuk **mempercepat development**, bukan menggantikan proses belajar
4. **Review dan testing** tetap dilakukan secara manual

---

## 6. Kesimpulan

### 6.1 Ringkasan Pencapaian

Pengembangan aplikasi mobile **Peukan Rumoh** menggunakan Flutter telah berhasil mencapai tujuan:

1. **Cross-Platform App**: Aplikasi dapat berjalan di Android, iOS, dan Web dari satu codebase Flutter.

2. **Integrasi Backend**: Aplikasi berhasil terintegrasi dengan REST API Laravel menggunakan Dio HTTP client dengan token-based authentication.

3. **State Management**: Implementasi Provider pattern yang efektif untuk mengelola state aplikasi secara reaktif.

4. **Modern UI/UX**: Desain Material Design 3 dengan dukungan dark/light mode, animasi smooth, dan responsif.

5. **Fitur Lengkap Pembeli**: Semua fitur belanja tersedia (browse, cart, checkout, orders, profile).

### 6.2 Statistik Pengembangan

| Komponen | Jumlah |
|----------|:------:|
| Models | 6 |
| Providers | 4 |
| Screens | 14 |
| Widgets | 3 |
| Services | 1 |
| Total Dart Files | 28 |
| Total Properties (Model) | 47 |
| Total Methods (Provider) | 19 |
| Dependencies | 7 |

### 6.3 Saran Pengembangan

Untuk pengembangan lebih lanjut, aplikasi mobile dapat ditingkatkan dengan:

1. **Push Notifications**: Implementasi Firebase Cloud Messaging untuk notifikasi order
2. **Offline Mode**: SQLite untuk cache data produk offline
3. **Biometric Auth**: Login dengan sidik jari atau Face ID
4. **Maps Integration**: Google Maps untuk tracking kurir real-time
5. **Chat Feature**: Fitur chat dengan pedagang
6. **Wishlist**: Fitur simpan produk favorit
7. **Deep Linking**: Navigasi langsung dari notifikasi ke screen tertentu

### 6.4 Penutup

Aplikasi mobile Peukan Rumoh berhasil menjadi companion app yang melengkapi sistem web Laravel, memberikan pengalaman belanja yang praktis dan modern bagi pembeli melalui smartphone mereka. Dengan arsitektur yang baik dan fitur yang lengkap, aplikasi ini siap untuk digunakan dan dikembangkan lebih lanjut.

---
