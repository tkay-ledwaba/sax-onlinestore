import 'dart:convert';

class Product{

  int price;
  String name;
  String image;
  String product_type;

  Product({
    required this.price,
    required this.name,
    required this.image,
    required this.product_type,
  });

  Product copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
  }){
   return Product(
       price: id ?? this.price,
       name: title ?? this.name,
       image: image ?? this.image,
       product_type: description ?? this.product_type
   );
  }

  Map<String, dynamic> toMap(){
    return {
      'price': price,
      'name': name,
      'image': image,
      'product_type': product_type
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        price: map['price'],
        name: map['name'],
        image: map['image'],
        product_type: map['product_type'],
    );
  }
  
  String toJson() => json.encode(toMap());
  
  factory Product.fromJson(String source) => Product.fromMap(
      json.decode(source));

}