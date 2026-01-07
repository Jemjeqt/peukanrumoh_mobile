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
  final ProductReturn? productReturn;

  Order({
    required this.id,
    required this.userId,
    required this.total,
    required this.shippingCost,
    required this.adminFee,
    required this.status,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.phone,
    this.notes,
    this.paidAt,
    required this.createdAt,
    this.items = const [],
    this.productReturn,
  });

  double get grandTotal => total + shippingCost + adminFee;

  // Get display status (considering return status)
  String get displayStatus {
    if (productReturn != null) {
      return productReturn!.status;
    }
    return status;
  }

  // Check if has active return
  bool get hasActiveReturn => productReturn != null;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      total: double.tryParse(json['total']?.toString() ?? '0') ?? 0.0,
      shippingCost: double.tryParse(json['shipping_cost']?.toString() ?? '0') ?? 0.0,
      adminFee: double.tryParse(json['admin_fee']?.toString() ?? '0') ?? 0.0,
      status: json['status']?.toString() ?? 'pending',
      paymentMethod: json['payment_method']?.toString() ?? '',
      shippingAddress: json['shipping_address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      notes: json['notes']?.toString(),
      paidAt: json['paid_at'] != null ? DateTime.tryParse(json['paid_at'].toString()) : null,
      createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ?? DateTime.now(),
      items: json['items'] != null
          ? (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList()
          : [],
      productReturn: json['product_return'] != null 
          ? ProductReturn.fromJson(json['product_return']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'total': total,
      'shipping_cost': shippingCost,
      'admin_fee': adminFee,
      'status': status,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'phone': phone,
      'notes': notes,
      'paid_at': paidAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class ProductReturn {
  final int id;
  final String status;
  final String type;
  final String reason;

  ProductReturn({
    required this.id,
    required this.status,
    required this.type,
    required this.reason,
  });

  factory ProductReturn.fromJson(Map<String, dynamic> json) {
    return ProductReturn(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      status: json['status']?.toString() ?? 'pending',
      type: json['type']?.toString() ?? '',
      reason: json['reason']?.toString() ?? '',
    );
  }

  String get statusLabel {
    switch (status) {
      case 'pending':
        return 'Return Diajukan';
      case 'approved':
        return 'Return Disetujui';
      case 'rejected':
        return 'Return Ditolak';
      case 'replacement_sent':
        return 'Barang Pengganti Dikirim';
      case 'replacement_delivered':
        return 'Menunggu Konfirmasi Pengganti';
      case 'refund_sent':
        return 'Dana Dikembalikan';
      case 'completed':
        return 'Return Selesai';
      default:
        return 'Return: $status';
    }
  }
}

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final double subtotal;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      orderId: int.tryParse(json['order_id']?.toString() ?? '0') ?? 0,
      productId: int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
      productName: json['product_name']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      subtotal: double.tryParse(json['subtotal']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}
