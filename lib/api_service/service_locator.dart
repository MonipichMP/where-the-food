import 'package:get_it/get_it.dart';
import 'package:where_the_food/api_service/auth_api_service.dart';
import 'package:where_the_food/api_service/category_api_service.dart';
import 'package:where_the_food/api_service/menu_api_service.dart';
import 'package:where_the_food/api_service/order_api_service.dart';

GetIt getIt = GetIt.instance;

void registerLocator() {
  getIt.registerLazySingleton(() => CategoryApiService());
  getIt.registerLazySingleton(() => MenuApiService());
  getIt.registerLazySingleton(() => OrderApiService());
  getIt.registerLazySingleton(() => AuthApiService());
}
