class CategoryResponse {
  final String? id;
  final String? name;
  final int? v;

  CategoryResponse({
    this.id,
    this.name,
    this.v,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
        id: json['_id'],
        name: json['name'],
        v: json['__v'],
      );
}
