import 'product.dart';

class CartItem {
  final int id;
  final int userId;
  final int productId;
  final int quantity;
  final Product? product;

  CartItem({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
    this.product,
  });

  double get subtotal {
    if (product != null) {
      return quantity * product!.price;
    }
    return 0;
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      productId: int.tryParse(json['product_id']?.toString() ?? '0') ?? 0,
      quantity: int.tryParse(json['quantity']?.toString() ?? '0') ?? 0,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
      'product': product?.toJson(),
    };
  }
}
