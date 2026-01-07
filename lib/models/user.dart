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

  /// Get full avatar URL
  String? get avatarUrl {
    if (avatar == null || avatar!.isEmpty) return null;
    // If already a full URL, return as is
    if (avatar!.startsWith('http')) return avatar;
    // Otherwise, prepend base URL
    return 'https://peukanrumoh.sisteminformasikotacerdas.id/storage/$avatar';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString(),
      phone: json['phone']?.toString(),
      address: json['address']?.toString(),
      avatar: json['avatar']?.toString(),
    );
  }

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

  /// Create a copy with updated fields
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? address,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      avatar: avatar ?? this.avatar,
    );
  }
}
