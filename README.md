# Peukan Rumoh - Mobile App (Buyer)

Aplikasi mobile Flutter untuk pembeli di platform e-commerce Peukan Rumoh. Aplikasi ini terhubung dengan backend Laravel dan menggunakan REST API.

## 🚀 Fitur Utama

### Autentikasi
- ✅ Login & Register
- ✅ Logout dengan token management
- ✅ Auto-login dengan token tersimpan

### Belanja
- ✅ Katalog produk dengan filter kategori
- ✅ Detail produk dengan gambar, deskripsi, dan stok
- ✅ Keranjang belanja (tambah, hapus, update quantity)
- ✅ Checkout dengan form alamat dan catatan
- ✅ Pilihan metode pembayaran (COD, Transfer, E-Wallet)

### Pesanan
- ✅ Riwayat pesanan dengan status badge
- ✅ Konfirmasi penerimaan pesanan
- ✅ **Review produk** dengan rating bintang (1-5)
- ✅ **Request return** dengan upload foto bukti
- ✅ Konfirmasi barang pengganti/refund
- ✅ Status return terintegrasi

### Profil
- ✅ Edit profile (nama, telepon, alamat)
- ✅ Ganti password
- ✅ Dark/Light mode toggle

## 📁 Struktur Folder

```
lib/
├── config/              # API Configuration
│   └── api_config.dart
├── models/              # Model data
│   ├── user.dart
│   ├── product.dart
│   ├── cart_item.dart
│   └── order.dart       # Termasuk ProductReturn
├── providers/           # State management dengan Provider
│   ├── auth_provider.dart
│   ├── cart_provider.dart
│   ├── product_provider.dart
│   └── theme_provider.dart
├── services/            # API service layer
│   └── api_service.dart
├── screens/             # UI Screens
│   ├── auth/            # Login & Register
│   ├── home/            # Home & Product Detail
│   ├── cart/            # Shopping Cart
│   ├── checkout/        # Checkout & Payment
│   ├── orders/          # Order History, Review, Return
│   └── settings/        # Profile & Settings
├── widgets/             # Reusable Widgets
└── main.dart            # Entry point
```

## ⚙️ Setup & Instalasi

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Konfigurasi API URL

Buka file `lib/config/api_config.dart`:

```dart
class ApiConfig {
  // Production
  static const String baseUrl = 'https://peukanrumoh.sisteminformasikotacerdas.id';
  
  // Development (uncomment untuk local testing)
  // static const String baseUrl = 'http://10.0.2.2:8000';  // Android Emulator
  // static const String baseUrl = 'http://localhost:8000'; // iOS Simulator
}
```

### 3. Jalankan Flutter App

```bash
# Debug mode
flutter run

# Build APK
flutter build apk --release
```

## 📝 API Endpoints

### Authentication
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| POST | `/api/register` | Daftar user baru |
| POST | `/api/login` | Login user |
| POST | `/api/logout` | Logout user |
| GET | `/api/user` | Get user data |
| PUT | `/api/user/update` | Update profile |
| PUT | `/api/user/change-password` | Ganti password |

### Products
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/products` | List produk |
| GET | `/api/products/{id}` | Detail produk |

### Cart
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/cart` | List keranjang |
| POST | `/api/cart` | Tambah ke keranjang |
| PUT | `/api/cart/{id}` | Update quantity |
| DELETE | `/api/cart/{id}` | Hapus item |

### Orders
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `/api/orders` | Riwayat pesanan |
| POST | `/api/orders` | Buat pesanan baru |
| POST | `/api/orders/{id}/payment` | Konfirmasi pembayaran |
| POST | `/api/orders/{id}/confirm-delivery` | Konfirmasi diterima |
| POST | `/api/orders/{id}/review` | Submit review |
| POST | `/api/orders/{id}/return` | Request return |
| POST | `/api/orders/{id}/confirm-replacement` | Konfirmasi pengganti |
| POST | `/api/orders/{id}/confirm-refund` | Konfirmasi refund |

## 🛠️ Tech Stack

| Komponen | Teknologi |
|----------|-----------|
| Framework | Flutter 3.x |
| Language | Dart 3.x |
| State Management | Provider |
| HTTP Client | Dio |
| Local Storage | SharedPreferences |
| Image Picker | image_picker |

## 👥 Tim Pengembang

| Nama | Role |
|------|------|
| Nashrullah Al Himni | Pengembang Inti & Autentikasi |
| Azhar Khairu Hafidz | Pengembang Toko & Keranjang |
| Aziz Faturrahman | Pengembang Pesanan & Profil |

## 📄 License

Project ini menggunakan lisensi yang sama dengan project Laravel utama.
