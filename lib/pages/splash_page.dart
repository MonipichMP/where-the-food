import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_assets.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/local_storage_service.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/pages/root_page.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  AsyncSubjectManager<bool> splashController = AsyncSubjectManager();

  Future onSplashing() async {
    splashController.addData(true);

    try {
      await LocalStorage.initSharedPref();
      // bool isLoggedIn = await LocalStorage.getLoginStatus();
      bool isLoggedIn = false;
      if (isLoggedIn) {
        // await AuthService.initLocalUserCredential();
        // UserProvider.getProvider(context).setLoginStatus(true);
        try {
          PageNavigator.pushReplacement(context, const RootPage());
          return true;
        } catch (e) {
          toastMessageError(e.toString(), context);
          return false;
        }
      } else {
        PageNavigator.pushReplacement(context, const RootPage());
        // PageNavigator.pushReplacement(context, const SignInPage());
      }
    } catch (error) {
      splashController.addError(error);
    }
  }

  @override
  void initState() {
    onSplashing();
    super.initState();
  }

  @override
  void dispose() {
    splashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomStreamHandler<bool?>(
        stream: splashController.stream,
        errorWidget: (error) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                FlutterIcons.hourglass_empty_mdi,
                size: 100,
                color: AppColor.primary,
              ),
              Text(
                "Data is Error",
                style: kSubtitleStyle.primary.bold,
              ),
            ],
          );
        },
        ready: (snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppAssets.imgLogo,
                  height: 100,
                  width: 100,
                ),
              ),
              const SpaceY(16),
              Center(
                child: Text(
                  "Where The Food",
                  style: kSubtitleStyle.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
