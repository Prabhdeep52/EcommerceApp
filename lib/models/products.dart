// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Product {
//   final String name;
//   final String description;
//   final double price;
//   final double quantity;
//   final String category;
//   final List<String> images;
//   final String? id;

//   Product({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.quantity,
//     required this.category,
//     required this.images,
//     this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'description': description,
//       'price': price,
//       'quantity': quantity,
//       'category': category,
//       'images': images,
//       'id': id,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       name: map['name'] as String,
//       description: map['description'] as String,
//       price: map['price'] as double,
//       quantity: map['quantity'] as double,
//       category: map['category'] as String,
//       images: List<String>.from(
//         (map['images'] as List<String>),
//       ),
//       id: map["_id"],
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) =>
//       Product.fromMap(json.decode(source) as Map<String, dynamic>);
// }
import 'dart:convert';

// import 'package:amazon_clone_tutorial/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  // final List<Rating>? rating;
  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    // this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      // 'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      // rating: map['ratings'] != null
      //     ? List<Rating>.from(
      //         map['ratings']?.map(
      //           (x) => Rating.fromMap(x),
      //         ),
      //       )
      //     : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
