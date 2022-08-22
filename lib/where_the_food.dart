import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_the_food/api_service/http_client.dart';
import 'package:where_the_food/pages/splash_page.dart';
import 'package:where_the_food/provider/category_provider.dart';
import 'package:where_the_food/provider/menu_provider.dart';
import 'package:where_the_food/provider/order_provider.dart';
import 'package:where_the_food/provider/user_provider.dart';

class WhereTheFood extends StatefulWidget {
  const WhereTheFood({Key? key}) : super(key: key);

  @override
  State<WhereTheFood> createState() => _WhereTheFoodState();
}

class _WhereTheFoodState extends State<WhereTheFood> {
  @override
  void initState() {
    super.initState();
    BaseHttpClient.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        Provider(create: (_) => CategoryProvider()),
        Provider(create: (_) => MenuProvider()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Where The Food',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashScreenPage(),
        );
      }),
    );
  }
}
