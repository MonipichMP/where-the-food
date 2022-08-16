import 'package:where_the_food/api_service/auth_api_service.dart';
import 'package:where_the_food/api_service/category_api_service.dart';
import 'package:where_the_food/api_service/menu_api_service.dart';
import 'package:where_the_food/api_service/order_api_service.dart';
import 'package:where_the_food/api_service/service_locator.dart';

final CategoryApiService categoryApiService = getIt<CategoryApiService>();
final MenuApiService menuApiService = getIt<MenuApiService>();
final OrderApiService orderApiService = getIt<OrderApiService>();
final AuthApiService authApiService = getIt<AuthApiService>();
