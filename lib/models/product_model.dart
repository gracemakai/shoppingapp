class ProductModel{
  String? name;
  int? price;
  String? imageUrl;
  String? id;

  ProductModel({this.name, this.price, this.imageUrl, this.id});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      id: map['id'] as String,
    );
  }
}