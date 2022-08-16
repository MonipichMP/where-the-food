import 'package:flutter/material.dart';
import 'package:where_the_food/where_the_food.dart';

import 'api_service/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  registerLocator();
  return runApp(const WhereTheFood());
}
