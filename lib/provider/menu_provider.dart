import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/model/response/menu_response.dart';

class MenuProvider {
  AsyncSubjectManager<List<MenuResponse>> managerList = AsyncSubjectManager();
  AsyncSubjectManager<MenuResponse> managerDetail = AsyncSubjectManager();
  int page = 1;

  static MenuProvider getProvider(BuildContext context, [bool listen = false]) =>
      Provider.of<MenuProvider>(context, listen: listen);

  Future<void> fetchData({
    bool reloading = false,
    required String catId,
  }) async {
    await managerList.asyncOperation(
      () async {
        return menuApiService.fetchMenuList(catID: catId);
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

  Future<void> fetchMenuDataDetail({bool reloading = false, required String id}) async {
    await managerDetail.asyncOperation(
      () async {
        return menuApiService.fetchMenuDetail(id);
      },
      reloading: reloading,
      onSuccess: (response) {
        return response;
      },
    );
  }

  void dispose() {
    managerList.dispose();
    managerDetail.dispose();
  }
}
