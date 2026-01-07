# Peukan Rumoh - Mobile App (Buyer)

Aplikasi mobile Flutter untuk pembeli di platform e-commerce Peukan Rumoh. Aplikasi ini terhubung dengan backend Laravel yang sudah ada dan menggunakan API yang sama.

## 🚀 Fitur Utama

- **Autentikasi**: Login dan Register
- **Katalog Produk**: Tampilan grid produk dengan gambar, harga, dan stok
- **Detail Produk**: Informasi lengkap produk dengan opsi tambah ke keranjang
- **Keranjang Belanja**: Kelola item keranjang (tambah, hapus, update jumlah)
- **Checkout**: Form pengisian alamat dan metode pembayaran
- **Riwayat Pesanan**: Lihat semua pesanan yang pernah dibuat

## 📁 Struktur Folder

```
lib/
├── models/              # Model data (User, Product, Cart, Order)
├── providers/           # State management dengan Provider
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   └── product_provider.dart
├── services/            # API service layer
│   └── api_service.dart
├── screens/             # UI Screens
│   ├── auth/            # Login & Register
│   ├── home/            # Home & Product Detail
│   ├── cart/            # Shopping Cart
│   ├── checkout/        # Checkout
│   └── orders/          # Order History & Success
└── main.dart            # Entry point
```

## ⚙️ Setup & Instalasi

### 1. Pastikan Flutter Sudah Terinstall

```bash
flutter --version
```

### 2. Install Dependencies

```bash
cd mobile_app_buyer
flutter pub get
```

### 3. Konfigurasi API URL

Buka file `lib/services/api_service.dart` dan sesuaikan `baseUrl` dengan environment Anda:

```dart
// Untuk Android Emulator
static const String baseUrl = 'http://10.0.2.2:8000/api';

// Untuk iOS Simulator
// static const String baseUrl = 'http://localhost:8000/api';

// Untuk Physical Device (ganti dengan IP komputer Anda)
// static const String baseUrl = 'http://YOUR_IP_ADDRESS:8000/api';
```

### 4. Jalankan Laravel Backend

Pastikan Laravel backend sudah berjalan:

```bash
# Di folder Laravel
php artisan serve
```

### 5. Jalankan Flutter App

```bash
# Pastikan emulator/device sudah terhubung
flutter devices

# Jalankan aplikasi
flutter run
```

## 📝 API Endpoints yang Digunakan

### Authentication
- `POST /api/register` - Daftar user baru
- `POST /api/login` - Login user
- `POST /api/logout` - Logout user
- `GET /api/user` - Get user data

### Products
- `GET /api/products` - List semua produk
- `GET /api/products/{id}` - Detail produk

### Cart
- `GET /api/cart` - List item keranjang
- `POST /api/cart` - Tambah ke keranjang
- `PUT /api/cart/{id}` - Update quantity
- `DELETE /api/cart/{id}` - Hapus item
- `DELETE /api/cart` - Kosongkan keranjang

### Orders
- `GET /api/orders` - Riwayat pesanan
- `POST /api/orders` - Buat pesanan baru (checkout)
- `GET /api/orders/{id}` - Detail pesanan
- `POST /api/orders/{id}/payment` - Konfirmasi pembayaran

## 🔐 State Management

Aplikasi ini menggunakan **Provider** untuk state management:

- **AuthProvider**: Mengelola status autentikasi user
- **ProductProvider**: Mengelola data produk
- **CartProvider**: Mengelola keranjang belanja

## 🎨 UI/UX

- Material Design 3
- Responsive layout
- Loading states
- Error handling
- Form validation

## 📱 Tested On

- Android Emulator (API 33)
- Flutter 3.38.5
- Dart 3.10.4

## ⚠️ Catatan Penting

1. **CORS**: Pastikan Laravel sudah dikonfigurasi untuk menerima request dari mobile app
2. **Network Permission**: Sudah otomatis ditambahkan di Android manifest
3. **HTTPS**: Untuk production, gunakan HTTPS endpoint

## 🐛 Troubleshooting

### Tidak bisa connect ke API
- Pastikan Laravel backend sudah running
- Cek URL di `api_service.dart` sudah benar
- Untuk Android emulator, gunakan `10.0.2.2` bukan `localhost`

### Image tidak muncul
- Pastikan folder `storage` sudah di-link: `php artisan storage:link`
- Cek path image di backend

### Login gagal
- Cek response dari API di console
- Pastikan role user adalah 'pembeli'

## 📄 License

Project ini menggunakan lisensi yang sama dengan project Laravel utama.
