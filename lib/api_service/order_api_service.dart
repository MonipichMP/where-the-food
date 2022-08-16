import 'package:where_the_food/api_service/base_api_service.dart';
import 'package:where_the_food/constant/app_constant.dart';
import 'package:where_the_food/model/response/order_response.dart';

class OrderApiService extends BaseApiService {
  static const String getOrderList = "/orders";
  static const String postOrder = "/orders";
  static const String getOrderDetail = "/order";

  Future<List<OrderResponse>> fetchOrderList() async {
    return onRequest(
      path: getOrderList,
      onSuccess: (response) {
        return List<OrderResponse>.from(response.data.map((x) => OrderResponse.fromJson(x)));
      },
    );
  }

  Future<OrderResponse> fetchOrderDetail(String id) async {
    return onRequest(
      path: "$getOrderDetail/$id",
      onSuccess: (response) {
        return OrderResponse.fromJson(response.data);
      },
    );
  }

  Future<OrderResponse> loginUser({List<String>? items}) async {
    return onRequest(
      path: postOrder,
      method: HttpMethod.POST,
      data: {
        "items": items,
      },
      onSuccess: (response) {
        return OrderResponse.fromJson(response.data);
      },
    );
  }
}
