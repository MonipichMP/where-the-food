import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/app_config.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/menu_response.dart';
import 'package:where_the_food/provider/menu_provider.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';

class MenuDetailPage extends StatefulWidget {
  final String categoryId;
  const MenuDetailPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _MenuDetailPageState createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  @override
  void initState() {
    super.initState();
    MenuProvider.getProvider(context).fetchMenuDataDetail(
      reloading: true,
      id: widget.categoryId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = MenuProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Menu",
      ),
      body: CustomStreamHandler<MenuResponse>(
        stream: menuProvider.managerDetail.stream,
        ready: (menu) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "${AppConfig.BASE_URL}/${menu.image}",
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${menu.name}",
                      style: kHeaderStyle,
                    ),
                    const SpaceY(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${menu.category?.name}",
                              style: kSubHeaderStyle.white,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SpaceX(),
                        Container(
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
                              "${menu.price}\$",
                              style: kSubHeaderStyle.white,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${menu.description}",
                      style: kSubHeaderStyle,
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
