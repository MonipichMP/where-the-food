import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/src/provider.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/app_config.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/menu_response.dart';
import 'package:where_the_food/provider/order_provider.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/empty_list_widget.dart';
import 'package:where_the_food/widgets/primary_button.dart';

class InCartPage extends StatefulWidget {
  const InCartPage({Key? key}) : super(key: key);

  @override
  _InCartPageState createState() => _InCartPageState();
}

class _InCartPageState extends State<InCartPage> {
  ValueNotifier<List<MenuResponse>> itemsNotifier = ValueNotifier([]);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    itemsNotifier.value = context.watch<OrderProvider>().myOrderList;
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Items in Cart",
      ),
      body: SuraNotifier(
        valueNotifier: itemsNotifier,
        builder: (List<MenuResponse> items) {
          if (items.isEmpty) {
            return const Center(
              child: EmptyListWidget(
                title: "Order",
              ),
            );
          } else {
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
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: AppColor.gradientColors,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: AppColor.gradientColors,
                                    ),
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "${AppConfig.BASE_URL}/${item.image}",
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColor.redColor,
                                          Colors.orange,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${item.price}\$",
                                        style: kSubHeaderStyle.white,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SpaceY(12),
                            Text(
                              "${item.name}",
                              style: kSubHeaderStyle.white,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                PrimaryButton(
                  roundRect: 0,
                  onPressed: () async {
                    try {
                      List<String> itemsInString = [];
                      for (var item in items) {
                        if (item.id != null) itemsInString.add(item.id!);
                      }
                      await orderApiService.makeOrder(items: itemsInString);
                      toastMessageSuccess("Success order", context);
                      OrderProvider.getProvider(context).clearOrderList();
                      PageNavigator.pop(context);
                    } catch (e) {
                      toastMessageError("Error when order", context);
                    }
                  },
                  child: Row(
                    children: const [
                      Text(
                        "Order",
                        style: kTitleStyle,
                      ),
                      SpaceX(16),
                      Icon(
                        FlutterIcons.dollar_sign_fea,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
