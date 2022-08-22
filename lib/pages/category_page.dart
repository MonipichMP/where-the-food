import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/src/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/category_response.dart';
import 'package:where_the_food/pages/category_detail_page.dart';
import 'package:where_the_food/pages/in_cart_page.dart';
import 'package:where_the_food/pages/order_history_page.dart';
import 'package:where_the_food/pages/sign_in_page.dart';
import 'package:where_the_food/provider/category_provider.dart';
import 'package:where_the_food/provider/order_provider.dart';
import 'package:where_the_food/provider/user_provider.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';
import 'package:where_the_food/widgets/primary_button.dart';

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
    final orderListCount = context.watch<OrderProvider>().myOrderList.length;
    final isLogin = context.watch<UserProvider>().isLoggedIn;
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Where The Food",
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (UserProvider.getProvider(context).isLoggedIn) {
                PageNavigator.push(context, const OrderHistoryPage());
              } else {
                PageNavigator.push(context, const SignInPage());
              }
            },
            icon: const Icon(
              FlutterIcons.history_mco,
              color: Colors.white,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (UserProvider.getProvider(context).isLoggedIn) {
                    PageNavigator.push(context, const InCartPage());
                  } else {
                    PageNavigator.push(context, const SignInPage());
                  }
                },
                icon: const Icon(
                  FlutterIcons.shoppingcart_ant,
                  color: Colors.white,
                ),
              ),
              if (orderListCount > 0)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColor.redColor,
                          Colors.orange,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "$orderListCount",
                        style: kSubtitleStyle.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: CustomStreamHandler<List<CategoryResponse>>(
        stream: categoryProvider.managerList.stream,
        ready: (categories) {
          return Column(
            children: [
              GridView.builder(
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
              ),
              const Spacer(),
              PrimaryButton(
                roundRect: 0,
                color: isLogin ? AppColor.redColor : AppColor.primary,
                onPressed: () async {
                  try {
                    if (isLogin) {
                      UserProvider.getProvider(context).logoutUser();
                      toastMessageSuccess("Success logoutUser", context);
                    } else {
                      PageNavigator.push(context, const SignInPage());
                    }
                  } catch (e) {
                    toastMessageError("Error when authenticate", context);
                  }
                },
                child: Row(
                  children: [
                    Text(
                      isLogin ? "Logout" : "Login",
                      style: kTitleStyle,
                    ),
                    const SpaceX(16),
                    Icon(
                      isLogin ? FlutterIcons.logout_ant : FlutterIcons.login_ant,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
