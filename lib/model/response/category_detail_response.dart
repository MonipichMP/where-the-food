import 'package:where_the_food/model/response/menu_response.dart';

class CategoryDetailResponse {
  final String? id;
  final String? name;
  final MenuResponse? menu;
  final int? v;

  CategoryDetailResponse({
    this.id,
    this.name,
    this.menu,
    this.v,
  });

  factory CategoryDetailResponse.fromJson(Map<String, dynamic> json) => CategoryDetailResponse(
        id: json['_id'],
        name: json['name'],
        menu: json['menu'] == null ? null : MenuResponse.fromJson(json['menu']),
        v: json['__v'],
      );
}
