import 'package:where_the_food/model/response/login_response.dart';
import 'package:where_the_food/model/response/menu_response.dart';

class OrderResponse {
  final String? id;
  final dynamic user;
  final DateTime? date;
  final List<MenuResponse>? menu;
  final int? v;

  OrderResponse({
    this.id,
    this.user,
    this.date,
    this.menu,
    this.v,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        id: json['_id'],
        user: json['user'] == null
            ? null
            : json['user'] is String
                ? json['user']
                : AuthResponse.fromJson(json['user']),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        menu: json["menu"] == null ? null : List<MenuResponse>.from(json["menu"].map((x) => MenuResponse.fromJson(x))),
        v: json['__v'],
      );
}
