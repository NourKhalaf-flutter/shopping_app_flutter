class CartModel {
  final String id;
  final String name;
  final int quantity;
  final String price;
  final String image;
  final String description;

  CartModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    required this.description,
  });

  CartModel copyWith({int? quantity}) {
    return CartModel(
      id: id,
      name: name,
      quantity: quantity ?? this.quantity,
      price: price,
      image: image,
      description: description,
    );
  }
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      image: map['image'],
      description: map['description'],
    );
  }

}
