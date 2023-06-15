import 'dart:convert';

class Collection{

  int id;
  String title;
  String image;
  String description;

  Collection({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  Collection copyWith({
    int? id,
    String? title,
    String? image,
    String? description,
  }){
   return Collection(
       id: id ?? this.id,
       title: title ?? this.title,
       image: image ?? this.image,
       description: description ?? this.description
   );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        description: map['description'],
    );
  }
  
  String toJson() => json.encode(toMap());
  
  factory Collection.fromJson(String source) => Collection.fromMap(
      json.decode(source));

}