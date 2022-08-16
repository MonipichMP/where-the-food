import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/app_config.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/order_response.dart';
import 'package:where_the_food/pages/menu_detail_page.dart';
import 'package:where_the_food/provider/order_provider.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderId;
  const OrderDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    OrderProvider.getProvider(context).fetchOrderDataDetail(
      reloading: true,
      id: widget.orderId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = OrderProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Menu",
      ),
      body: CustomStreamHandler<OrderResponse>(
        stream: orderProvider.managerDetail.stream,
        ready: (order) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SpaceY(),
                    Text(
                      order.date != null ? "Date ordered: ${order.date!.formatDate()}" : "",
                      style: kSubHeaderStyle,
                    ),
                    const SpaceY(),
                    Text(
                      order.user != null ? "Ordered by: ${order.user!.fullName} (${order.user!.username})" : "",
                      style: kSubHeaderStyle,
                    ),
                  ],
                ),
              ),
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
                itemCount: order.menu?.length ?? 1,
                itemBuilder: (context, index) {
                  if (order.menu != null) {
                    final menu = order.menu![index];
                    return InkWell(
                      onTap: () {
                        PageNavigator.push(context, MenuDetailPage(categoryId: menu.id ?? ""));
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: AppColor.primary,
                                  borderRadius: BorderRadius.circular(15.0),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "${AppConfig.BASE_URL}/${menu.image}",
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.redColor,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${menu.price}\$",
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
                            "${menu.name}",
                            style: kSubHeaderStyle.primary,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text(
                      "No Item found.",
                      style: kSubHeaderStyle.white,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
