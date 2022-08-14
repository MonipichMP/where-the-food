import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:where_the_food/pages/splash_page.dart';
import 'package:where_the_food/provider/bottom_navigation_provider.dart';
import 'package:where_the_food/provider/user_provider.dart';

class WhereTheFood extends StatelessWidget {
  const WhereTheFood({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Where The Food',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreenPage(),
        );
      }),
    );
  }
}
