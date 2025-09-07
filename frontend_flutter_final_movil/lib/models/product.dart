class Product {
  final int? id;
  String name;
  String description;
  double price;
  String? imageUrl;
  String category; // 👈 nuevo campo obligatorio

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.category, // 👈 requerido
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] is int
          ? json['id']
          : (json['id'] == null ? null : int.tryParse(json['id'].toString())),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: json['price'] is num
          ? (json['price'] as num).toDouble()
          : double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      imageUrl: json['imageUrl']?.toString(),
      category: json['category']?.toString() ?? '', // 👈 asegúrate que venga
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final map = <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'category': category, // 👈 mandarlo siempre
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
    if (includeId && id != null) map['id'] = id;
    return map;
  }
}
