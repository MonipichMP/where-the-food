import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/model/response/menu_response.dart';
import 'package:where_the_food/model/response/order_response.dart';

class OrderProvider with ChangeNotifier {
  AsyncSubjectManager<List<OrderResponse>> managerList = AsyncSubjectManager();
  AsyncSubjectManager<OrderResponse> managerDetail = AsyncSubjectManager();
  int page = 1;

  static OrderProvider getProvider(BuildContext context, [bool listen = false]) =>
      Provider.of<OrderProvider>(context, listen: listen);

  Future<void> fetchData({bool reloading = false}) async {
    await managerList.asyncOperation(
      () async {
        return orderApiService.fetchOrderList();
      },
      reloading: reloading,
      onSuccess: (response) {
        if (managerList.hasData) {
          response = [...managerList.value!, ...response];
        }
        return response;
      },
    );
  }

  Future<void> fetchOrderDataDetail({bool reloading = false, required String id}) async {
    await managerDetail.asyncOperation(
      () async {
        return orderApiService.fetchOrderDetail(id);
      },
      reloading: reloading,
      onSuccess: (response) {
        return response;
      },
    );
  }

  final List<MenuResponse> _myOrderList = [];
  List<MenuResponse> get myOrderList => _myOrderList;

  void addToOrderList(MenuResponse menu) {
    _myOrderList.add(menu);
    notifyListeners();
  }

  void removeFromOrderList(MenuResponse menu) {
    _myOrderList.remove(menu);
    notifyListeners();
  }

  void clearOrderList() {
    _myOrderList.clear();
    notifyListeners();
  }

  void dispose() {
    managerList.dispose();
    managerDetail.dispose();
  }
}
