import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/app_constant.dart';
import 'package:where_the_food/constant/local_storage_service.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/model/response/login_response.dart';
import 'package:where_the_food/provider/user_provider.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/appbar_custom.dart';
import 'package:where_the_food/widgets/custom_stream_handler.dart';
import 'package:where_the_food/widgets/primary_button.dart';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({Key? key}) : super(key: key);

  @override
  _AccountDetailPageState createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  void onLogOut() async {
    SuraNavigator.dialog(
      SuraConfirmationDialog(
        content: const Text("Are you sure want to logout?"),
        title: "Logout?",
        onConfirm: () async {
          try {
            UserProvider.getProvider(context).logoutUser();
            AppConstant.clearData();
            await LocalStorage.deleteAll();
            Navigator.of(context).pop(true);
          } catch (e) {
            toastMessageError(e.toString(), context);
          }
        },
        confirmText: "Ok",
        cancelText: "Cancel",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = UserProvider.getProvider(context);
    return Scaffold(
      appBar: AppBarCustom.myAppBar(
        title: "User",
      ),
      body: CustomStreamHandler<AuthResponse>(
        stream: userProvider.managerLogin.stream,
        ready: (user) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  FlutterIcons.user_ant,
                  color: AppColor.primary,
                  size: 52,
                ),
                const SpaceY(),
                Text(
                  "Full Name: ${user.fullName}",
                  style: kSubHeaderStyle,
                ),
                const SpaceY(),
                if (user.username != null)
                  Text(
                    "Username: ${user.username}",
                    style: kSubHeaderStyle,
                  ),
                if (user.username != null) const SpaceY(),
                Text(
                  "Date Of Birth: ${user.dateOfBirth!.formatDate(format: "yyyy-MM-dd")}",
                  style: kSubHeaderStyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PrimaryButton(
                    color: AppColor.redColor,
                    onPressed: onLogOut,
                    child: Text("logout".toUpperCase()),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
