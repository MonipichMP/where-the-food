import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/category_response.dart';
import 'package:where_the_food/pages/account_detail_page.dart';
import 'package:where_the_food/pages/category_detail_page.dart';
import 'package:where_the_food/pages/order_page.dart';
import 'package:where_the_food/pages/sign_in_page.dart';
import 'package:where_the_food/provider/category_provider.dart';
import 'package:where_the_food/provider/user_provider.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    CategoryProvider.getProvider(context).fetchData(reloading: true);
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = CategoryProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Where The Food",
        actions: [
          if (UserProvider.getProvider(context).isLoggedIn)
            IconButton(
              onPressed: () {
                PageNavigator.push(context, const OrderPage());
              },
              icon: const Icon(
                FlutterIcons.shoppingcart_ant,
                color: Colors.white,
              ),
            ),
          IconButton(
            onPressed: () {
              if (UserProvider.getProvider(context).isLoggedIn) {
                PageNavigator.push(context, const AccountDetailPage());
              } else {
                PageNavigator.push(context, const SignInPage());
              }
            },
            icon: const Icon(
              FlutterIcons.user_ant,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: CustomStreamHandler<List<CategoryResponse>>(
        stream: categoryProvider.managerList.stream,
        ready: (categories) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return InkWell(
                onTap: () {
                  PageNavigator.push(context, CategoryDetailPage(category: category));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppColor.gradientColors,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "${category.name}",
                      style: kSubHeaderStyle.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
