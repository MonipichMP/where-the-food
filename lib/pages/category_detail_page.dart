import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/app_config.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/category_response.dart';
import 'package:where_the_food/model/response/order_response.dart';
import 'package:where_the_food/pages/menu_detail_page.dart';
import 'package:where_the_food/provider/category_provider.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';
import 'package:where_the_food/widgets/empty_list_widget.dart';

class CategoryDetailPage extends StatefulWidget {
  final CategoryResponse category;
  const CategoryDetailPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  void initState() {
    super.initState();
    CategoryProvider.getProvider(context).fetchCategoryDetail(
      reloading: true,
      id: widget.category.id ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = CategoryProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "Category ${widget.category.name} items",
      ),
      body: CustomStreamHandler<OrderResponse>(
        stream: categoryProvider.managerDetail.stream,
        ready: (category) {
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
            itemCount: category.menu?.length,
            itemBuilder: (context, index) {
              if (category.menu != null) {
                final menu = category.menu![index];
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
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: AppColor.gradientColors,
                              ),
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
                return const Center(
                  child: EmptyListWidget(
                    title: "Category",
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
