import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_assets.dart';
import 'package:where_the_food/constant/style.dart';

class EmptyListWidget extends StatelessWidget {
  final String title;
  final double widthHeight;

  const EmptyListWidget({Key? key, required this.title, this.widthHeight = 150}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssets.icEmptyPng,
          width: widthHeight,
          height: widthHeight,
        ),
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
