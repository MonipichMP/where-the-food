import 'package:where_the_food/api_service/base_api_service.dart';
import 'package:where_the_food/model/response/menu_response.dart';

class MenuApiService extends BaseApiService {
  static const String getMenuList = "/menus";
  static const String getMenuDetail = "/menu";

  Future<List<MenuResponse>> fetchMenuList({required String catID}) async {
    return onRequest(
      path: getMenuList,
      query: {"catId": catID},
      onSuccess: (response) {
        return List<MenuResponse>.from(response.data.map((x) => MenuResponse.fromJson(x)));
      },
    );
  }

  Future<MenuResponse> fetchMenuDetail(String id) async {
    return onRequest(
      path: "$getMenuDetail/$id",
      onSuccess: (response) {
        return MenuResponse.fromJson(response.data);
      },
    );
  }
}
