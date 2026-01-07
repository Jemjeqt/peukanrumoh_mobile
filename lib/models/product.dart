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

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.image,
    this.category,
    required this.userId,
    this.isActive = true,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      stock: int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
      image: json['image']?.toString(),
      category: json['category']?.toString(),
      userId: int.tryParse(json['user_id']?.toString() ?? '0') ?? 0,
      isActive: json['is_active'] == true || json['is_active'] == 1 || json['is_active'] == '1',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image': image,
      'category': category,
      'user_id': userId,
      'is_active': isActive,
    };
  }
}
