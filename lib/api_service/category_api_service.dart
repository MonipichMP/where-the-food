import 'package:where_the_food/api_service/base_api_service.dart';
import 'package:where_the_food/model/response/category_response.dart';
import 'package:where_the_food/model/response/order_response.dart';

class CategoryApiService extends BaseApiService {
  static const String getCategoryList = "/categories";
  static const String getCategoryDetail = "/category";

  Future<List<CategoryResponse>> fetchCategoryList() async {
    return onRequest(
      path: getCategoryList,
      onSuccess: (response) {
        return List<CategoryResponse>.from(response.data.map((x) => CategoryResponse.fromJson(x)));
      },
    );
  }

  Future<OrderResponse> fetchCategoryDetail(String id) async {
    return onRequest(
      path: "$getCategoryDetail/$id",
      onSuccess: (response) {
        return OrderResponse.fromJson(response.data);
      },
    );
  }
}
