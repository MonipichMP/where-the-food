import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/order_response.dart';
import 'package:where_the_food/pages/order_detail_page.dart';
import 'package:where_the_food/provider/order_provider.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';
import 'package:where_the_food/widgets/empty_list_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    OrderProvider.getProvider(context).fetchData(reloading: true);
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = OrderProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Cart History",
      ),
      body: CustomStreamHandler<List<OrderResponse>>(
        stream: orderProvider.managerList.stream,
        ready: (orders) {
          if (orders.isEmpty) {
            return const Center(
              child: EmptyListWidget(
                title: "Cart",
              ),
            );
          } else {
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
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders.reversed.toList()[index];
                return InkWell(
                  onTap: () {
                    PageNavigator.push(context, OrderDetailPage(orderId: order.id ?? ''));
                  },
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FlutterIcons.shoppingcart_ant,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SpaceY(16),
                        Text(
                          order.date != null ? order.date!.formatDate() : "",
                          style: kSubHeaderStyle.white,
                        ),
                        const SpaceY(16),
                        Text(
                          order.menu != null && order.menu!.isNotEmpty ? "Menu: ${order.menu!.length}" : "",
                          style: kSubHeaderStyle.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
