import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/model/response/category_response.dart';
import 'package:where_the_food/model/response/order_response.dart';

class CategoryProvider {
  AsyncSubjectManager<List<CategoryResponse>> managerList = AsyncSubjectManager();
  AsyncSubjectManager<OrderResponse> managerDetail = AsyncSubjectManager();
  int page = 1;

  static CategoryProvider getProvider(BuildContext context, [bool listen = false]) =>
      Provider.of<CategoryProvider>(context, listen: listen);

  Future<void> fetchData({bool reloading = false}) async {
    await managerList.asyncOperation(
      () async {
        return categoryApiService.fetchCategoryList();
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

  Future<void> fetchCategoryDetail({bool reloading = false, required String id}) async {
    await managerDetail.asyncOperation(
      () async {
        return categoryApiService.fetchCategoryDetail(id);
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
