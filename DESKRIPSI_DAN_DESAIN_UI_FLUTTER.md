# DOKUMENTASI LENGKAP APLIKASI MOBILE PEUKAN RUMOH (FLUTTER)

---

# DESKRIPSI RANCANGAN APLIKASI MOBILE

## 1. Latar Belakang

**Peukan Rumoh Mobile** adalah aplikasi mobile e-commerce yang dikembangkan menggunakan **Flutter** untuk platform Android, iOS, dan Web. Aplikasi ini merupakan pendamping dari sistem web Laravel, khusus dirancang untuk pengguna dengan role **Pembeli (Customer)** agar dapat berbelanja dengan mudah dari smartphone mereka.

## 2. Tujuan Aplikasi Mobile

| No | Tujuan | Deskripsi |
|---|---------|-----------|
| 1 | **Kemudahan Akses** | Pembeli dapat berbelanja kapan saja dan di mana saja melalui smartphone |
| 2 | **User Experience** | Pengalaman belanja yang intuitif dengan desain modern dan responsif |
| 3 | **Performa Optimal** | Aplikasi native-like dengan loading cepat dan smooth animations |
| 4 | **Sinkronisasi Real-time** | Data cart, order, dan profile tersinkronisasi dengan backend Laravel |
| 5 | **Offline Capability** | Cache images dan data untuk pengalaman yang lebih baik |

## 3. Ruang Lingkup Aplikasi

### 3.1 Fitur Utama Aplikasi Mobile

```
┌─────────────────────────────────────────────────────────────────┐
│                    PEUKAN RUMOH MOBILE APP                      │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │                     PEMBELI (BUYER)                      │   │
│  ├──────────────────────────────────────────────────────────┤   │
│  │                                                          │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │   AUTH      │  │   SHOP      │  │   CART      │       │   │
│  │  ├─────────────┤  ├─────────────┤  ├─────────────┤       │   │
│  │  │• Register   │  │• Browse     │  │• View Items │       │   │
│  │  │• Login      │  │• Produk     │  │• Update Qty │       │   │
│  │  │• Logout     │  │• Kategori   │  │• Remove     │       │   │
│  │  │• Forgot PWD │  │• Detail     │  │• Clear Cart │       │   │
│  │  └─────────────┘  │• Add Cart   │  └─────────────┘       │   │
│  │                   └─────────────┘                        │   │
│  │                                                          │   │
│  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐       │   │
│  │  │  CHECKOUT   │  │   ORDERS    │  │  PROFILE    │       │   │
│  │  ├─────────────┤  ├─────────────┤  ├─────────────┤       │   │
│  │  │• Alamat     │  │• Riwayat    │  │• Edit Data  │       │   │
│  │  │• Payment    │  │• Tracking   │  │• Change PWD │       │   │
│  │  │• Konfirmasi │  │• Detail     │  │• Alamat     │       │   │
│  │  │• Bayar      │  │• Status     │  │• Theme      │       │  │
│  │  └─────────────┘  └─────────────┘  └─────────────┘       │   │
│  │                                                          │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Alur Utama Aplikasi

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  Splash  │───▶│  Login/  │───▶│   Home   │───▶│  Browse  │
│  Screen  │    │ Register │    │  Screen  │    │ Products │
└──────────┘    └──────────┘    └──────────┘    └────┬─────┘
                                                      │
    ┌─────────────────────────────────────────────────┘
    ▼
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│  Produk  │───▶│   Cart   │───▶│ Checkout │───▶│ Payment  │
│  Detail  │    │  Screen  │    │  Screen  │    │  Screen  │
└──────────┘    └──────────┘    └──────────┘    └────┬─────┘
                                                      │
    ┌─────────────────────────────────────────────────┘
    ▼
┌──────────┐    ┌──────────┐
│  Order   │───▶│  Order   │
│ Success  │    │  Detail  │
└──────────┘    └──────────┘
```

## 4. Arsitektur Aplikasi

### 4.1 Arsitektur MVC dengan Provider Pattern

```
+-----------------------------------------------------------------------+
|                     FLUTTER MVC ARCHITECTURE                          |
+-----------------------------------------------------------------------+
|                                                                       |
|  +-------------+         +-------------+         +-------------+      |
|  |    VIEW     |<------->| CONTROLLER  |<------->|    MODEL    |      |
|  |  (Screens)  |         |  (Provider) |         |   (Data)    |      |
|  +-------------+         +-------------+         +-------------+      |
|  | - auth/     |         | - AuthProv  |         | - User      |      |
|  |   login     |         | - ProductPr |         | - Product   |      |
|  |   register  |         | - CartProv  |         | - CartItem  |      |
|  | - home/     |         | - ThemeProv |         | - Order     |      |
|  |   home      |         |             |         | - OrderItem |      |
|  |   detail    |         |             |         |             |      |
|  | - cart/     |         +------+------+         +------+------+      |
|  | - checkout/ |                |                       |             |
|  | - orders/   |                |                       |             |
|  | - settings/ |                v                       v             |
|  +-------------+         +-------------+         +-------------+      |
|                          |   SERVICE   |         | API CONFIG  |      |
|                          |  ApiService |         | Endpoints   |      |
|                          +------+------+         +-------------+      |
|                                 |                                     |
|                                 v                                     |
|                          +-------------+                              |
|                          |  Laravel    |                              |
|                          |  REST API   |                              |
|                          +-------------+                              |
+-----------------------------------------------------------------------+
```

### 4.2 Teknologi yang Digunakan

| Komponen | Teknologi | Versi | Keterangan |
|----------|-----------|-------|------------|
| Framework | Flutter | 3.10+ | Cross-platform UI Framework |
| Language | Dart | 3.10+ | Programming Language |
| State Management | Provider | 6.1.1 | ChangeNotifier Pattern |
| HTTP Client | Dio | 5.4.0 | Advanced HTTP Client |
| Local Storage | SharedPreferences | 2.2.2 | Token & Settings Storage |
| Image Loading | cached_network_image | 3.3.1 | Image Caching |
| Loading Effect | Shimmer | 3.0.0 | Skeleton Loading |
| Image Picker | image_picker | 1.0.7 | Camera/Gallery Access |
| Design | Material 3 | - | Google Material Design |

### 4.3 Struktur Folder Projek

```
lib/
├── config/                          # Konfigurasi
│   └── api_config.dart              # Base URL & Endpoints
│
├── core/                            # Core utilities
│   └── ...
│
├── data/                            # Data layer
│   └── ...
│
├── models/                          # Data Models
│   ├── user.dart                    # User model
│   ├── product.dart                 # Product model
│   ├── cart_item.dart               # CartItem model
│   └── order.dart                   # Order & OrderItem models
│
├── providers/                       # State Management
│   ├── auth_provider.dart           # Auth state & methods
│   ├── product_provider.dart        # Product state & methods
│   ├── cart_provider.dart           # Cart state & methods
│   └── theme_provider.dart          # Theme state (dark/light)
│
├── screens/                         # UI Screens
│   ├── auth/
│   │   ├── login_screen.dart        # Login page
│   │   └── register_screen.dart     # Registration page
│   ├── home/
│   │   ├── home_screen.dart         # Product listing
│   │   └── product_detail_screen.dart
│   ├── cart/
│   │   └── cart_screen.dart         # Shopping cart
│   ├── checkout/
│   │   ├── checkout_screen.dart     # Checkout form
│   │   └── payment_screen.dart      # Payment confirmation
│   ├── orders/
│   │   ├── orders_screen.dart       # Order history
│   │   └── order_success_screen.dart
│   ├── settings/
│   │   ├── edit_profile_screen.dart
│   │   ├── change_password_screen.dart
│   │   └── shipping_address_screen.dart
│   └── main_screen.dart             # Bottom Navigation Host
│
├── services/                        # API Services
│   └── api_service.dart             # Dio HTTP Client
│
├── widgets/                         # Reusable Widgets
│   ├── custom_widgets.dart          # CustomTextField, CustomButton
│   ├── product_card.dart            # Product card component
│   └── shimmer_loading.dart         # Loading skeleton
│
└── main.dart                        # App Entry Point + Themes
```

## 5. Model Data (Data Classes)

### 5.1 User Model

```dart
class User {
  final int id;
  final String name;
  final String email;
  final String? role;
  final String? phone;
  final String? address;
  final String? avatar;

  // Methods
  String? get avatarUrl;           // Full avatar URL
  factory User.fromJson(...);      // JSON parsing
  Map<String, dynamic> toJson();   // JSON serialization
  User copyWith(...);              // Immutable update
}
```

### 5.2 Product Model

```dart
class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final int stock;
  final String? image;
  final String? category;
  final int userId;
  final bool isActive;

  // Methods
  factory Product.fromJson(...);
  Map<String, dynamic> toJson();
}
```

### 5.3 Order Model

```dart
class Order {
  final int id;
  final int userId;
  final double total;
  final double shippingCost;
  final double adminFee;
  final String status;
  final String paymentMethod;
  final String shippingAddress;
  final String phone;
  final String? notes;
  final DateTime? paidAt;
  final DateTime createdAt;
  final List<OrderItem> items;

  double get grandTotal => total + shippingCost + adminFee;
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final double subtotal;
}
```

## 6. Fitur Detail Aplikasi

### a. Splash Screen & Authentication

**1. Splash Screen**  
Saat aplikasi dibuka, animasi splash screen ditampilkan dengan logo Peukan Rumoh menggunakan fade dan scale animation. Sistem secara otomatis memeriksa token autentikasi yang tersimpan di SharedPreferences. Jika valid, pengguna langsung diarahkan ke Main Screen; jika tidak, ke Login Screen.

**2. Login**  
Pengguna memasukkan email dan password untuk masuk. Sistem memvalidasi kredensial melalui API dan menyimpan token JWT untuk sesi berikutnya. Terdapat validasi form real-time dan penanganan error yang informatif.

**3. Register**  
Pengguna baru dapat mendaftar dengan mengisi nama, email, dan password. Sistem otomatis mendaftarkan sebagai role "pembeli" dan melakukan login otomatis setelah registrasi berhasil.

**4. Logout**  
Pengguna dapat logout dari menu Profile. Token akan dihapus dari server dan local storage, kemudian pengguna diarahkan ke Login Screen.

---

### b. Home & Produk

**1. Home Screen**  
Menampilkan daftar produk dengan grid layout 2 kolom. Terdapat header dengan gradient, search bar, dan filter kategori. Produk ditampilkan dalam bentuk card dengan gambar, nama, harga, dan tombol add to cart.

**2. Product Detail**  
Menampilkan detail lengkap produk termasuk gambar besar, nama, harga, deskripsi, stok, dan pedagang. Terdapat selector quantity dan tombol "Tambah ke Keranjang" yang meng-trigger CartProvider.

**3. Kategori Filter**  
Chip kategori horizontal yang dapat di-scroll untuk memfilter produk: Semua, Sayuran, Buah, Daging, Ikan, Bumbu, Minuman, Snack, Lainnya.

---

### c. Keranjang & Checkout

**1. Cart Screen**  
Menampilkan daftar item di keranjang dengan gambar, nama, harga, quantity selector, dan tombol hapus. Terdapat ringkasan total di bagian bawah dan tombol checkout.

**2. Checkout Screen**  
Form untuk mengisi alamat pengiriman, nomor telepon, dan catatan. Menampilkan ringkasan pesanan dengan subtotal, biaya admin (Rp 10.000), ongkir (Rp 5.000), dan grand total.

**3. Payment Screen**  
Pilihan metode pembayaran: COD, Transfer Bank, E-Wallet. Menampilkan detail rekening tujuan dan tombol konfirmasi pembayaran.

**4. Order Success**  
Halaman konfirmasi dengan animasi sukses, detail order, dan tombol untuk melihat riwayat pesanan.

---

### d. Riwayat Pesanan

**1. Orders Screen**  
Menampilkan daftar semua pesanan dengan status badge berwarna. Filter berdasarkan status tersedia. Setiap card menampilkan nomor order, tanggal, jumlah item, total, dan status.

**2. Order Detail**  
Detail lengkap pesanan termasuk timeline status, daftar item, alamat pengiriman, dan informasi pembayaran.

---

### e. Profile & Settings

**1. Profile Page**  
Menampilkan avatar (inisial nama jika tidak ada foto), nama, email, dan menu settings. Menu tersedia: Edit Profile, Ganti Password, Alamat Pengiriman, Dark Mode Toggle, Bantuan, Tentang, Logout.

**2. Edit Profile**  
Form untuk mengubah nama, nomor telepon, dan alamat. Perubahan di-sync ke backend dan state lokal diperbarui.

**3. Change Password**  
Form dengan validasi untuk mengubah password. Memerlukan password lama, password baru, dan konfirmasi.

**4. Shipping Address**  
Kelola alamat pengiriman tersimpan. Dapat menambah, edit, pilih default, dan hapus alamat.

**5. Theme Toggle**  
Switch untuk mengubah antara Light Mode dan Dark Mode. Preferensi disimpan di local storage.

---

# DESAIN UI RANCANGAN FLUTTER

## 1. Konsep Desain

### 1.1 Design Philosophy

| Aspek | Implementasi |
|-------|--------------|
| **Design System** | Material Design 3 (Material You) |
| **Color Scheme** | Teal-Green Gradient (#11998E → #38EF7D) sebagai primary |
| **Typography** | System font dengan hierarki yang jelas |
| **Components** | Card-based dengan rounded corners (16dp) |
| **Animations** | Smooth transitions, fade, scale animations |
| **Dark Mode** | Full support dengan adaptive colors |

### 1.2 Color Palette

```
+-----------------------------------------------------------+
|                   FLUTTER COLOR PALETTE                   |
+-----------------------------------------------------------+
|                                                           |
|  PRIMARY GRADIENT (AppColors.primaryGradient)             |
|  +---------------------------------------------+          |
|  |  #11998E  ---------------------> #38EF7D|          |
|  |  (Teal)                          (Green)    |          |
|  +---------------------------------------------+          |
|                                                           |
|  ACCENT & BRAND                                           |
|  +---------+  +---------+  +---------+                    |
|  |#FF6F00  |  |#FF6B35  |  |#5C6BC0  |                    |
|  | Accent  |  | Orange  |  | Indigo  |                    |
|  +---------+  +---------+  +---------+                    |
|                                                           |
|  LIGHT MODE                                               |
|  +---------+  +---------+  +---------+  +---------+       |
|  |#F8FAFC  |  |#FFFFFF  |  |#1E293B  |  |#64748B  |       |
|  |  BG     |  |  Card   |  | Text 1  |  | Text 2  |       |
|  +---------+  +---------+  +---------+  +---------+       |
|                                                           |
|  DARK MODE                                                |
|  +---------+  +---------+  +---------+  +---------+       |
|  |#0F172A  |  |#1E293B  |  |#F1F5F9  |  |#94A3B8  |       |
|  |  BG     |  |  Card   |  | Text 1  |  | Text 2  |       |
|  +---------+  +---------+  +---------+  +---------+       |
|                                                           |
|  STATUS COLORS                                            |
|  +---------+  +---------+  +---------+                    |
|  |#2ECC71  |  |#F39C12  |  |#E74C3C  |                    |
|  | Success |  | Warning |  |  Error  |                    |
|  +---------+  +---------+  +---------+                    |
|                                                           |
+-----------------------------------------------------------+
```

## 2. Screen Layouts

### 2.1 Splash Screen

```
+------------------------------------------+
|                                          |
|          (Gradient Background)           |
|                                          |
|                                          |
|              +--------+                  |
|              |  LOGO  |                  |
|              | (Icon) |                  |
|              +--------+                  |
|                                          |
|           Peukan Rumoh                   |
|        (Orange accent: Rumoh)            |
|                                          |
|       Pasar Online Terpercaya            |
|                                          |
|              [Loading...]                |
|                                          |
|                                          |
+------------------------------------------+
```

### 2.2 Login Screen

```
+------------------------------------------+
|                                          |
|          (Gradient Header)               |
|                                          |
|              PEUKAN RUMOH                |
|          Pasar Online Terpercaya         |
|                                          |
+------------------------------------------+
|                                          |
|     Masuk ke Akun Anda                   |
|                                          |
|  +------------------------------------+  |
|  | [E]  Email                         |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [P]  Password                  [*] |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  |         [*] MASUK                  |  |
|  |       (Gradient Button)            |  |
|  +------------------------------------+  |
|                                          |
|     Belum punya akun? Daftar            |
|                                          |
+------------------------------------------+
```

### 2.3 Main Screen (Bottom Navigation)

```
+------------------------------------------+
|  [=] Peukan Rumoh           [Dark Mode]  |
+------------------------------------------+
|                                          |
|          (Active Page Content)           |
|                                          |
|  Home / Cart / Orders / Profile          |
|                                          |
|                                          |
|                                          |
|                                          |
|                                          |
|                                          |
|                                          |
+------------------------------------------+
|                                          |
|  +--------+--------+--------+--------+   |
|  | [H]    |  [C]    |  [O]   |  [P]   |  |
|  | Beranda|Keranjang| Pesanan| Profil |  |
|  | (3)    |         |        |        |  |
|  +--------+--------+--------+--------+   |
|                                          |  
+------------------------------------------+
```

### 2.4 Home Screen

```
+------------------------------------------+
|  Peukan Rumoh                      [Q]   |
+------------------------------------------+
|                                          |
|  Selamat Berbelanja, [Nama]!             |
|                                          |
|  [Semua][Sayuran][Buah][Daging][Ikan]... |
|                                          |
|  +-------------+  +-------------+        |
|  |   [IMAGE]   |  |   [IMAGE]   |        |
|  |             |  |             |        |
|  | Produk 1    |  | Produk 2    |        |
|  | Rp 25.000   |  | Rp 30.000   |        |
|  | (*) 4.5     |  | (*) 4.8     |        |
|  |  [+] Cart   |  |  [+] Cart   |        |
|  +-------------+  +-------------+        |
|                                          |
|  +-------------+  +-------------+        |
|  |   [IMAGE]   |  |   [IMAGE]   |        |
|  |   ...       |  |   ...       |        |
|  +-------------+  +-------------+        |
|                                          |
+------------------------------------------+
```

### 2.5 Product Detail Screen

```
+------------------------------------------+
|  <- Detail Produk                        |
+------------------------------------------+
|                                          |
|  +------------------------------------+  |
|  |                                    |  |
|  |           [PRODUCT IMAGE]          |  |
|  |              (Large)               |  |
|  |                                    |  |
|  +------------------------------------+  |
|                                          |
|  Nama Produk Lengkap                     |
|  Rp 25.000                               |
|                                          |
|  [*****] 4.5  (120 ulasan)               |
|                                          |
|  Stok: 50 tersedia                       |
|  Toko: Nama Pedagang                     |
|                                          |
|  Deskripsi:                              |
|  Lorem ipsum dolor sit amet,             |
|  consectetur adipiscing elit...          |
|                                          |
|  +--------+  +------------------------+  |
|  |  - 1 + |  | [+] Tambah Keranjang  |  |
|  +--------+  +------------------------+  |
|                                          |
+------------------------------------------+
```

### 2.6 Cart Screen

```
+------------------------------------------+
|  [C] Keranjang                     [X]   |
+------------------------------------------+
|                                          |
|  +------------------------------------+  |
|  | [IMG] | Produk 1                   |  |
|  |       | Rp 25.000                  |  |
|  |       | - [2] +          [x]       |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [IMG] | Produk 2                   |  |
|  |       | Rp 30.000                  |  |
|  |       | - [1] +          [x]       |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [IMG] | Produk 3                   |  |
|  |       | Rp 15.000                  |  |
|  |       | - [3] +          [x]       |  |
|  +------------------------------------+  |
|                                          |
+------------------------------------------+
|  Subtotal       :        Rp  95.000      |
|  Biaya Admin    :        Rp  10.000      |
|  Ongkos Kirim   :        Rp   5.000      |
|  -------------------------------------   |
|  TOTAL          :       Rp 110.000       |
|                                          |
|  +------------------------------------+  |
|  |         [*] CHECKOUT              |  |
|  +------------------------------------+  |
+------------------------------------------+
```

### 2.7 Checkout Screen

```
+------------------------------------------+
|  <- Checkout                             |
+------------------------------------------+
|                                          |
|  [A] Alamat Pengiriman                   |
|  +------------------------------------+  |
|  | Alamat lengkap...                  |  |
|  |                                    |  |
|  +------------------------------------+  |
|                                          |
|  [T] Nomor Telepon                       |
|  +------------------------------------+  |
|  | 08XXXXXXXXXX                       |  |
|  +------------------------------------+  |
|                                          |
|  [N] Catatan (Optional)                  |
|  +------------------------------------+  |
|  | Catatan untuk kurir...             |  |
|  +------------------------------------+  |
|                                          |
|  -------------------------------------   |
|  Ringkasan Pesanan                       |
|                                          |
|  3 item                    Rp  95.000    |
|  Biaya Admin               Rp  10.000    |
|  Ongkir                    Rp   5.000    |
|  TOTAL                    Rp 110.000     |
|                                          |
|  +------------------------------------+  |
|  |      [*] PILIH PEMBAYARAN         |  |
|  +------------------------------------+  |
+------------------------------------------+
```

### 2.8 Profile Page

```
+------------------------------------------+
|  Profil                                  |
+------------------------------------------+
|                                          |
|           +----------+                   |
|           |   AB     |  (Avatar/Initial) |
|           +----------+                   |
|                                          |
|           Ahmad Budi                     |
|         ahmad@email.com                  |
|                                          |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [U]  Edit Profil                >  |  |
|  +------------------------------------+  |
|  | [P]  Ganti Password             >  |  |
|  +------------------------------------+  |
|  | [A]  Alamat Pengiriman          >  |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [M]  Mode Gelap          [Toggle] |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [?]  Bantuan                    >  |  |
|  +------------------------------------+  |
|  | [i]  Tentang Aplikasi           >  |  |
|  +------------------------------------+  |
|                                          |
|  +------------------------------------+  |
|  | [X]  Keluar                     >  |  |
|  +------------------------------------+  |
|                                          |
+------------------------------------------+
```

## 3. Komponen UI Standar

### 3.1 Button Styles

```
+-----------------------------------------------------------------------+
|                        FLUTTER BUTTON COMPONENTS                      |
+-----------------------------------------------------------------------+
|                                                                       |
|  ELEVATED BUTTON (Primary)           OUTLINED BUTTON (Secondary)      |
|  +------------------------+          +------------------------+       |
|  |  [+] Tambah Keranjang  |          |      <- Kembali        |       |
|  |   (Green Gradient)     |          |    (Border Primary)    |       |
|  +------------------------+          +------------------------+       |
|                                                                       |
|  TEXT BUTTON                         ICON BUTTON                      |
|  +------------------------+          +-------+                        |
|  |     Lihat Detail ->    |          |  [Q]  |                        |
|  |    (Primary Color)     |          +-------+                        |
|  +------------------------+                                           |
|                                                                       |
|  FLOATING ACTION BUTTON              GRADIENT CONTAINER BUTTON        |
|  +-------+                           +------------------------+       |
|  |   +   |                           |      CHECKOUT          |       |
|  +-------+                           |  (Gradient Background) |       |
|                                      +------------------------+       |
|                                                                       |
+-----------------------------------------------------------------------+
```

### 3.2 Card Components

```
+-----------------------------------------------------------------------+
|                       FLUTTER CARD COMPONENTS                         |
+-----------------------------------------------------------------------+
|                                                                       |
|  PRODUCT CARD                                                         |
|  +-------------------+                                                |
|  |     [IMAGE]       |  - CachedNetworkImage                          |
|  |                   |  - Placeholder shimmer                         |
|  +-------------------+                                                |
|  | Product Name      |  - Text maxLines: 2                            |
|  | Rp 25.000         |  - Price formatting                            |
|  | (*) 4.5           |  - Rating row                                  |
|  | [+] Add to Cart   |  - IconButton with badge                       |
|  +-------------------+                                                |
|                                                                       |
|  ORDER CARD                                                           |
|  +-------------------------------------------+                        |
|  | #ORD-001              [STATUS BADGE]      |                        |
|  | 2 Jan 2026                                |                        |
|  | ----------------------------------------- |                        |
|  | 3 items                     Rp 110.000    |                        |
|  +-------------------------------------------+                        |
|                                                                       |
|  CART ITEM CARD                                                       |
|  +-------------------------------------------+                        |
|  | [IMG] | Product Name                      |                        |
|  |       | Rp 25.000                         |                        |
|  |       | [-] 2 [+]               [X]       |                        |
|  +-------------------------------------------+                        |
|                                                                       |
+-----------------------------------------------------------------------+
```

### 3.3 Input Components

```
+---------------------------------------------------------------------+
|                      FLUTTER INPUT COMPONENTS                       |
+---------------------------------------------------------------------+
|                                                                     |
|  TEXT FIELD (CustomTextField)                                       |
|  +-------------------------------------------+                      |
|  | [E]  Email                                |                      |
|  | +---------------------------------------+ |                      |
|  | | user@example.com                      | |                      |
|  | +---------------------------------------+ |                      |
|  | [!] Format email tidak valid              | (Error state)        |
|  +-------------------------------------------+                      |
|                                                                     |
|  PASSWORD FIELD                                                     |
|  +-------------------------------------------+                      |
|  | [P]  Password                         [*] |                      |
|  | +---------------------------------------+ |                      |
|  | | ........                              | |                      |
|  | +---------------------------------------+ |                      |
|  +-------------------------------------------+                      |
|                                                                     |
|  SEARCH BAR                                                         |
|  +-------------------------------------------+                      |
|  | [Q]  Cari produk...                       |                      |
|  +-------------------------------------------+                      |
|                                                                     |
|  QUANTITY SELECTOR                                                  |
|  +-------+-------+-------+                                          |
|  |   -   |   2   |   +   |                                          |
|  +-------+-------+-------+                                          |
|                                                                     |
+---------------------------------------------------------------------+
```

### 3.4 Status Badges

```
+---------------------------------------------------------------------+
|                      FLUTTER STATUS BADGES                          |
+---------------------------------------------------------------------+
|                                                                     |
|  Container dengan BoxDecoration dan BorderRadius                    |
|                                                                     |
|  +-----------+  +-----------+  +-----------+  +-----------+         |
|  | PENDING   |  |   PAID    |  |PROCESSING |  |READY PICK |         |
|  |  (Gray)   |  |  (Blue)   |  | (Yellow)  |  | (Orange)  |         |
|  +-----------+  +-----------+  +-----------+  +-----------+         |
|                                                                     |
|  +-----------+  +-----------+  +-----------+                        |
|  |  SHIPPED  |  | COMPLETED |  | CANCELLED |                        |
|  | (Purple)  |  |  (Green)  |  |   (Red)   |                        |
|  +-----------+  +-----------+  +-----------+                        |
|                                                                     |
+---------------------------------------------------------------------+
```

## 4. Navigasi & Routing

### 4.1 Bottom Navigation

```dart
BottomNavigationBar(
  currentIndex: _selectedIndex,
  onTap: _onTabTapped,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Badge(label: count, child: Icon(Icons.shopping_cart)), label: 'Keranjang'),
    BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Pesanan'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ],
)
```

### 4.2 Screen Navigation

| From | To | Method |
|------|-----|--------|
| Splash | Login/Main | Navigator.pushReplacement |
| Login | Main | Navigator.pushReplacement |
| Home | ProductDetail | Navigator.push |
| Cart | Checkout | Navigator.push |
| Checkout | Payment | Navigator.push |
| Payment | OrderSuccess | Navigator.pushReplacement |
| Profile | EditProfile | Navigator.push |
| Profile | ChangePassword | Navigator.push |
| Profile | ShippingAddress | Navigator.push |

## 5. State Management Flow

```
+-----------------------------------------------------------------------+
|                         PROVIDER STATE FLOW                           |
+-----------------------------------------------------------------------+
|                                                                       |
|  ┌──────────────┐                                                     |
|  │   MyApp      │  MultiProvider wrapper                              |
|  └──────┬───────┘                                                     |
|         │                                                             |
|         ▼                                                             |
|  ┌──────────────────────────────────────────────────────────────┐     |
|  │                      PROVIDERS                               │     |
|  │  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐ │     |
|  │  │AuthProvider│ │ProductProv │ │ CartProv   │ │ ThemeProv  │ │     |
|  │  │• user      │ │• products  │ │• items     │ │• themeMode │ │     |
|  │  │• isLoading │ │• isLoading │ │• itemCount │ │            │ │     |
|  │  │• error     │ │• error     │ │• total     │ │            │ │     |
|  │  └─────┬──────┘ └─────┬──────┘ └─────┬──────┘ └────────────┘ │     |
|  └────────┼──────────────┼──────────────┼───────────────────────┘     |
|           │              │              │                             |
|           ▼              ▼              ▼                             |
|  ┌──────────────────────────────────────────────────────────────┐     |
|  │                         VIEW (Widgets)                       │     |
|  │  Consumer<AuthProvider>   context.watch<CartProvider>        │     |
|  │  Provider.of<ProductProvider>(context)                       │     |
|  └──────────────────────────────────────────────────────────────┘     |
|                                                                       |
+-----------------------------------------------------------------------+
```

## 6. Loading & Error States

### 6.1 Shimmer Loading

```
+------------------------------------------+
|                                          |
|  +-------------+  +-------------+        |
|  | ░░░░░░░░░░░ |  | ░░░░░░░░░░░ |        |
|  | ░░░░░░░░░░░ |  | ░░░░░░░░░░░ |        |
|  | ░░░░░░░░░░░ |  | ░░░░░░░░░░░ |        |
|  | ░░░░░░░     |  | ░░░░░░░     |        |
|  | ░░░░░       |  | ░░░░░       |        |
|  +-------------+  +-------------+        |
|                                          |
|  +-------------+  +-------------+        |
|  | ░░░░░░░░░░░ |  | ░░░░░░░░░░░ |        |
|  | ...         |  | ...         |        |
|  +-------------+  +-------------+        |
|                                          |
+------------------------------------------+
```

### 6.2 Error State

```
+------------------------------------------+
|                                          |
|                 ⚠️                       |
|                                          |
|         Terjadi Kesalahan                |
|                                          |
|    Tidak dapat memuat data produk        |
|                                          |
|         [🔄 Coba Lagi]                   |
|                                          |
+------------------------------------------+
```

### 6.3 Empty State

```
+------------------------------------------+
|                                          |
|                 🛒                       |
|                                          |
|        Keranjang Kosong                  |
|                                          |
|     Ayo mulai berbelanja produk          |
|         segar berkualitas!               |
|                                          |
|         [Belanja Sekarang]               |
|                                          |
+------------------------------------------+
```

## 7. Responsive Design

Flutter otomatis menyesuaikan layout berdasarkan ukuran layar menggunakan:

- **MediaQuery** untuk mendapatkan dimensi layar
- **LayoutBuilder** untuk responsive widgets
- **GridView** dengan crossAxisCount dinamis
- **Flexible** dan **Expanded** untuk proportional sizing

---

## 8. Dependencies (pubspec.yaml)

```yaml
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
```

---

