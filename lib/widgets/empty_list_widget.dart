import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;

  const EmptyListWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          FlutterIcons.creative_commons_zero_faw5d,
          size: 75,
          color: AppColor.primary,
        ),
        const SpaceY(16),
        Text(
          "$title is Empty",
          style: kSubtitleStyle.primary.bold,
        ),
        const SpaceY(),
        Text(
          "Sorry Data Seems to be empty.",
          style: kSubtitleStyle.primary,
        ),
      ],
    );
  }
}
