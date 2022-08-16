import 'package:where_the_food/model/response/category_response.dart';

class MenuResponse {
  final String? id;
  final String? name;
  final String? image;
  final String? description;
  final num? price;
  final dynamic category;
  final int? v;

  MenuResponse({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.category,
    this.v,
  });

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        id: json['_id'],
        name: json['name'],
        image: json['image'],
        description: json['description'],
        price: json['price'],
        category: json['category'] == null
            ? null
            : json['category'] is String
                ? json['category']
                : CategoryResponse.fromJson(json['category']),
        v: json['__v'],
      );
}
