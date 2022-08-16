import 'package:flutter/material.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';

class AppBarCustom {
  static AppBar myAppBar({
    String? title,
    List<Widget> actions = const [],
    bool centerTitle = false,
    double elevation = 1,
    PreferredSizeWidget? bottom,
    Widget? leading,
    Widget? titleWidget,
    double? toolbarHeight,
    bool automaticallyImplyLeading = true,
  }) {
    return AppBar(
      title: titleWidget ?? Text(title ?? "", style: kHeaderStyle.white),
      leading: leading,
      actions: actions,
      automaticallyImplyLeading: automaticallyImplyLeading,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: AppColor.gradientColors,
          ),
        ),
      ),
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: bottom,
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
    );
  }
}
