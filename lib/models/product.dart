class Product {
  final int? id;
  final String name;
  final String category;
  final String expirationDate;
  final double price;
  final int stock;
  final String description;

  const Product({
    this.id,
    required this.name,
    required this.category,
    required this.expirationDate,
    required this.price,
    required this.stock,
    required this.description,
  });

  // Convert a Product into a Map. The keys must correspond to the
  // column names in the database.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'category': category,
      'expirationDate': expirationDate,
      'price': price,
      'stock': stock,
      'description': description,
    };
  }

  // Convert a Map into a Product.
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int?,
      name: map['name'] as String,
      category: map['category'] as String,
      expirationDate: map['expirationDate'] as String,
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] as int,
      description: map['description'] as String,
    );
  }

  // Helper method to copy with modifications
  Product copyWith({
    int? id,
    String? name,
    String? category,
    String? expirationDate,
    double? price,
    int? stock,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      expirationDate: expirationDate ?? this.expirationDate,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      description: description ?? this.description,
    );
  }
}
