# Dokumentasi UML - Peukan Rumoh
## Sistem E-Commerce Multi-Role

---

## 1. Use Case Diagram

```mermaid
graph TB
    subgraph Actors
        Admin["🔧 Admin"]
        Pedagang["🏪 Pedagang"]
        Kurir["🚚 Kurir"]
        Pembeli["🛒 Pembeli"]
        Guest["👤 Guest"]
    end
    
    subgraph "Use Cases"
        subgraph "Autentikasi"
            UC1["Login"]
            UC2["Register"]
            UC3["Logout"]
            UC4["Edit Profil"]
        end
        
        subgraph "Admin"
            UC5["Kelola Users"]
            UC6["Approve User"]
            UC7["Lihat Dashboard"]
            UC8["Kelola Returns"]
        end
        
        subgraph "Pedagang"
            UC9["Kelola Produk"]
            UC10["Lihat Pesanan Masuk"]
            UC11["Proses Pesanan"]
            UC12["Lihat Statistik"]
            UC13["Handle Return"]
        end
        
        subgraph "Kurir"
            UC14["Terima Pengiriman"]
            UC15["Update Status Pengiriman"]
            UC16["Konfirmasi Pengiriman"]
            UC17["Handle Return Pickup"]
        end
        
        subgraph "Pembeli"
            UC18["Lihat Produk"]
            UC19["Tambah ke Keranjang"]
            UC20["Checkout"]
            UC21["Bayar Pesanan"]
            UC22["Lihat Riwayat Pesanan"]
            UC23["Beri Review"]
            UC24["Ajukan Return"]
        end
    end
    
    Guest --> UC1
    Guest --> UC2
    Guest --> UC18
    
    Admin --> UC1
    Admin --> UC5
    Admin --> UC6
    Admin --> UC7
    Admin --> UC8
    Admin --> UC3
    Admin --> UC4
    
    Pedagang --> UC1
    Pedagang --> UC9
    Pedagang --> UC10
    Pedagang --> UC11
    Pedagang --> UC12
    Pedagang --> UC13
    Pedagang --> UC3
    Pedagang --> UC4
    
    Kurir --> UC1
    Kurir --> UC14
    Kurir --> UC15
    Kurir --> UC16
    Kurir --> UC17
    Kurir --> UC3
    Kurir --> UC4
    
    Pembeli --> UC1
    Pembeli --> UC18
    Pembeli --> UC19
    Pembeli --> UC20
    Pembeli --> UC21
    Pembeli --> UC22
    Pembeli --> UC23
    Pembeli --> UC24
    Pembeli --> UC3
    Pembeli --> UC4
```

---

## 2. Skenario Use Case

### UC-01: Login
| Item | Deskripsi |
|------|-----------|
| **Aktor** | Admin, Pedagang, Kurir, Pembeli |
| **Deskripsi** | User melakukan autentikasi ke sistem |
| **Precondition** | User memiliki akun terdaftar dan disetujui |
| **Main Flow** | 1. User membuka halaman login<br>2. User memasukkan email dan password<br>3. Sistem memvalidasi kredensial<br>4. Sistem redirect ke dashboard sesuai role |
| **Alternative** | 3a. Kredensial salah → tampilkan error<br>3b. Akun belum disetujui → tampilkan pesan menunggu |
| **Postcondition** | User berhasil login dan masuk ke dashboard |

---

### UC-09: Kelola Produk
| Item | Deskripsi |
|------|-----------|
| **Aktor** | Pedagang |
| **Deskripsi** | Pedagang mengelola produk miliknya |
| **Precondition** | Pedagang sudah login dan disetujui |
| **Main Flow** | 1. Pedagang membuka menu "Produk Saya"<br>2. Sistem menampilkan daftar produk<br>3. Pedagang dapat tambah/edit/hapus produk<br>4. Sistem menyimpan perubahan |
| **Alternative** | 3a. Validasi gagal → tampilkan error |
| **Postcondition** | Data produk tersimpan di database |

---

### UC-20: Checkout
| Item | Deskripsi |
|------|-----------|
| **Aktor** | Pembeli |
| **Deskripsi** | Pembeli melakukan checkout dari keranjang |
| **Precondition** | Keranjang tidak kosong, user sudah login |
| **Main Flow** | 1. Pembeli klik checkout<br>2. Sistem menampilkan ringkasan pesanan<br>3. Pembeli mengisi alamat pengiriman<br>4. Pembeli pilih metode pembayaran<br>5. Sistem membuat order baru<br>6. Keranjang dikosongkan |
| **Alternative** | 4a. Stok tidak cukup → tampilkan error |
| **Postcondition** | Order terbuat dengan status "pending" |

---

### UC-15: Update Status Pengiriman
| Item | Deskripsi |
|------|-----------|
| **Aktor** | Kurir |
| **Deskripsi** | Kurir mengupdate status pengiriman |
| **Precondition** | Kurir sudah ambil pesanan |
| **Main Flow** | 1. Kurir membuka daftar pengiriman<br>2. Kurir pilih order yang akan diupdate<br>3. Kurir klik "Selesaikan Pengiriman"<br>4. Sistem update status order ke "completed" |
| **Postcondition** | Order status menjadi "completed" |

---

### UC-24: Ajukan Return
| Item | Deskripsi |
|------|-----------|
| **Aktor** | Pembeli |
| **Deskripsi** | Pembeli mengajukan pengembalian barang |
| **Precondition** | Order sudah diterima (completed) |
| **Main Flow** | 1. Pembeli buka riwayat pesanan<br>2. Pembeli pilih order dan klik "Ajukan Return"<br>3. Pembeli isi alasan dan upload bukti<br>4. Pembeli pilih tipe (refund/replacement)<br>5. Sistem buat return request |
| **Alternative** | 3a. Bukti tidak valid → tampilkan error |
| **Postcondition** | Return request terbuat dengan status "pending" |

---

## 3. Activity Diagram

### Proses Pembelian (Checkout Flow)

```mermaid
flowchart TD
    Start([Start]) --> Browse["Pembeli Browse Produk"]
    Browse --> AddCart{"Tambah ke Keranjang?"}
    AddCart -->|Ya| Cart["Produk Masuk Keranjang"]
    AddCart -->|Tidak| Browse
    Cart --> More{"Belanja Lagi?"}
    More -->|Ya| Browse
    More -->|Tidak| Checkout["Klik Checkout"]
    Checkout --> FillAddress["Isi Alamat Pengiriman"]
    FillAddress --> SelectPayment["Pilih Metode Pembayaran"]
    SelectPayment --> ConfirmOrder["Konfirmasi Pesanan"]
    ConfirmOrder --> CreateOrder["Sistem Buat Order"]
    CreateOrder --> ClearCart["Kosongkan Keranjang"]
    ClearCart --> Pending["Order Status: Pending"]
    Pending --> Pay["Pembeli Bayar"]
    Pay --> VerifyPay{"Verifikasi Pembayaran"}
    VerifyPay -->|Valid| Paid["Order Status: Paid"]
    VerifyPay -->|Invalid| Pending
    Paid --> Process["Pedagang Proses"]
    Process --> Ready["Order Status: Ready Pickup"]
    Ready --> Pickup["Kurir Ambil Pesanan"]
    Pickup --> Shipping["Order Status: Shipped"]
    Shipping --> Deliver["Kurir Antar ke Pembeli"]
    Deliver --> Complete["Order Status: Completed"]
    Complete --> End([End])
```

---

### Proses Return Barang

```mermaid
flowchart TD
    Start([Start]) --> Request["Pembeli Ajukan Return"]
    Request --> Submit["Submit Alasan & Bukti"]
    Submit --> SelectType["Pilih: Refund / Replacement"]
    SelectType --> Pending["Status: Pending"]
    Pending --> AdminReview{"Admin Review"}
    AdminReview -->|Tolak| Rejected["Status: Rejected"]
    AdminReview -->|Setuju| Approved["Status: Approved"]
    Approved --> ReadyPickup["Status: Ready Pickup"]
    ReadyPickup --> KurirPickup["Kurir Ambil dari Pembeli"]
    KurirPickup --> Delivering["Kurir Antar ke Pedagang"]
    Delivering --> Received["Pedagang Terima Barang"]
    Received --> TypeCheck{"Tipe Return?"}
    TypeCheck -->|Refund| SendRefund["Pedagang Transfer Uang"]
    TypeCheck -->|Replacement| SendReplacement["Kirim Barang Pengganti"]
    SendRefund --> BuyerConfirm["Pembeli Konfirmasi"]
    SendReplacement --> BuyerConfirm
    BuyerConfirm --> Complete["Status: Completed"]
    Rejected --> End([End])
    Complete --> End
```

---

## 4. Class Diagram

```mermaid
classDiagram
    class User {
        +int id
        +string name
        +string email
        +string password
        +string role
        +boolean is_approved
        +string phone
        +string address
        +isAdmin() bool
        +isPedagang() bool
        +isKurir() bool
        +isPembeli() bool
    }
    
    class Product {
        +int id
        +int user_id
        +int market_id
        +string name
        +string description
        +decimal price
        +int stock
        +string image
        +string category
        +boolean is_active
        +getImageUrlAttribute() string
    }
    
    class Order {
        +int id
        +int user_id
        +int kurir_id
        +decimal total
        +decimal shipping_cost
        +decimal admin_fee
        +string status
        +string payment_method
        +string shipping_address
        +string phone
        +string notes
        +datetime paid_at
        +datetime picked_up_at
        +datetime delivered_at
        +getStatusLabel() string
        +getGrandTotal() decimal
    }
    
    class OrderItem {
        +int id
        +int order_id
        +int product_id
        +int quantity
        +decimal price
    }
    
    class Cart {
        +int id
        +int user_id
        +int product_id
        +int quantity
        +getSubtotalAttribute() float
    }
    
    class Review {
        +int id
        +int user_id
        +int product_id
        +int order_id
        +int rating
        +string comment
    }
    
    class Market {
        +int id
        +string name
        +string location
        +string description
    }
    
    class ProductReturn {
        +int id
        +int user_id
        +int order_id
        +int kurir_id
        +string reason
        +string evidence
        +string type
        +string status
        +datetime approved_at
        +datetime completed_at
        +getStatusLabel() string
    }
    
    User "1" --> "*" Product : owns
    User "1" --> "*" Order : places
    User "1" --> "*" Cart : has
    User "1" --> "*" Review : writes
    User "1" --> "*" ProductReturn : requests
    
    Product "*" --> "1" User : belongsTo pedagang
    Product "*" --> "1" Market : belongsTo
    Product "1" --> "*" OrderItem : has
    Product "1" --> "*" Cart : in
    Product "1" --> "*" Review : has
    
    Order "*" --> "1" User : belongsTo buyer
    Order "*" --> "1" User : belongsTo kurir
    Order "1" --> "*" OrderItem : contains
    Order "1" --> "*" ProductReturn : has
    
    OrderItem "*" --> "1" Order : belongsTo
    OrderItem "*" --> "1" Product : belongsTo
    
    Cart "*" --> "1" User : belongsTo
    Cart "*" --> "1" Product : contains
    
    Review "*" --> "1" User : belongsTo
    Review "*" --> "1" Product : belongsTo
    Review "*" --> "1" Order : belongsTo
    
    ProductReturn "*" --> "1" User : belongsTo buyer
    ProductReturn "*" --> "1" Order : belongsTo
    ProductReturn "*" --> "1" User : assignedTo kurir
```

---

## 5. Sequence Diagram

### Proses Checkout

```mermaid
sequenceDiagram
    participant P as Pembeli
    participant C as CartController
    participant CC as CheckoutController
    participant DB as Database
    participant O as Order Model
    
    P->>C: Lihat Keranjang
    C->>DB: Query Cart Items
    DB-->>C: Return Cart Data
    C-->>P: Tampilkan Keranjang
    
    P->>CC: Klik Checkout
    CC->>DB: Validate Cart Items
    CC-->>P: Tampilkan Form Checkout
    
    P->>CC: Submit Order (alamat, payment)
    CC->>O: Create New Order
    O->>DB: Insert Order
    O->>DB: Insert Order Items
    CC->>DB: Clear Cart
    CC-->>P: Redirect ke Order Detail
```

---

### Proses Pengiriman oleh Kurir

```mermaid
sequenceDiagram
    participant K as Kurir
    participant DC as DeliveryController
    participant O as Order Model
    participant DB as Database
    
    K->>DC: Lihat Daftar Pengiriman
    DC->>DB: Query Orders (status: ready_pickup)
    DB-->>DC: Return Available Orders
    DC-->>K: Tampilkan Daftar
    
    K->>DC: Terima Pengiriman (order_id)
    DC->>O: Update kurir_id, status
    O->>DB: Save Changes
    DC-->>K: Konfirmasi
    
    K->>DC: Selesaikan Pengiriman
    DC->>O: Update status: completed
    O->>DB: Save Changes
    DC-->>K: Pengiriman Selesai
```

---

### Proses Return Barang

```mermaid
sequenceDiagram
    participant PB as Pembeli
    participant RC as ReturnController
    participant R as ProductReturn Model
    participant Admin as Admin
    participant Kurir as Kurir
    participant PD as Pedagang
    
    PB->>RC: Ajukan Return
    RC-->>PB: Form Return
    PB->>RC: Submit (alasan, bukti, tipe)
    RC->>R: Create Return Request
    R-->>RC: Return Created (pending)
    
    Admin->>RC: Review Return
    RC->>R: Approve/Reject
    R-->>Admin: Status Updated
    
    Note over Kurir: Jika Approved
    Kurir->>RC: Pickup dari Pembeli
    RC->>R: Update: delivering
    
    Kurir->>RC: Antar ke Pedagang
    RC->>R: Update: received
    
    PD->>RC: Proses (refund/replacement)
    RC->>R: Update Status
    
    PB->>RC: Konfirmasi Terima
    RC->>R: Update: completed
```

---

## 6. Status Flow Diagram

### Order Status

```mermaid
stateDiagram-v2
    [*] --> pending : Order Created
    pending --> paid : Payment Verified
    pending --> cancelled : User Cancel
    paid --> processing : Pedagang Terima
    processing --> ready_pickup : Pedagang Siapkan
    ready_pickup --> shipped : Kurir Ambil
    shipped --> completed : Delivered
    cancelled --> [*]
    completed --> [*]
```

### Return Status

```mermaid
stateDiagram-v2
    [*] --> pending : Return Request
    pending --> approved : Admin Approve
    pending --> rejected : Admin Reject
    approved --> pickup : Ready for Pickup
    pickup --> delivering : Kurir Pickup
    delivering --> received : Pedagang Receive
    received --> refund_sent : Refund Transfer
    received --> replacement_shipping : Send Replacement
    refund_sent --> completed : Buyer Confirm
    replacement_shipping --> replacement_delivered : Delivered
    replacement_delivered --> completed : Buyer Confirm
    rejected --> [*]
    completed --> [*]
```

---

## Ringkasan Entitas

| Entitas | Deskripsi | Relasi Utama |
|---------|-----------|--------------|
| **User** | Pengguna sistem (Admin/Pedagang/Kurir/Pembeli) | Has many: Products, Orders, Carts |
| **Product** | Barang yang dijual pedagang | Belongs to: User, Market |
| **Order** | Pesanan dari pembeli | Has many: OrderItems |
| **OrderItem** | Detail item dalam pesanan | Belongs to: Order, Product |
| **Cart** | Keranjang belanja pembeli | Belongs to: User, Product |
| **Review** | Ulasan produk | Belongs to: User, Product, Order |
| **Market** | Data pasar tradisional | Has many: Products |
| **ProductReturn** | Permintaan pengembalian | Belongs to: User, Order |
