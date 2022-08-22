import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/pages/category_page.dart';
import 'package:where_the_food/pages/register_page.dart';
import 'package:where_the_food/service/auth_service.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/custom_text_field.dart';
import 'package:where_the_food/widgets/primary_button.dart';

class SignInPage extends StatefulWidget {
  final bool isPopBack;
  const SignInPage({Key? key, this.isPopBack = false}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SuraFormMixin {
  late TextEditingController userNameTC, passwordTC;
  late ValueNotifier<bool> isShowPasswordNotifier;

  void onLogin() async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        final authResponse = await authApiService.loginUser(
          username: userNameTC.text.trim(),
          password: passwordTC.text.trim(),
        );
        await AuthService.onLoginSuccess(context, authResponse);
        if (widget.isPopBack) {
          PageNavigator.pop(context);
        } else {
          PageNavigator.pushReplacement(context, const CategoryPage());
        }
      } catch (e) {
        debugPrint(e.toString());
        toastMessageError(e.toString(), context);
      }
    }
  }

  @override
  void initState() {
    userNameTC = TextEditingController(text: "");
    passwordTC = TextEditingController(text: "");
    isShowPasswordNotifier = ValueNotifier(true);
    super.initState();
  }

  @override
  void dispose() {
    userNameTC.dispose();
    passwordTC.dispose();
    isShowPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: AppColor.gradientColors,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLoginForm(),
                buildCreateAccount(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginForm() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "sign in".toUpperCase(),
              style: kSubHeaderStyle.white,
            ),
            const SpaceY(),
            CustomTextField(
              controller: userNameTC,
              prefix: const Icon(AntDesign.user, color: Colors.white),
              hint: "Username",
              textInputAction: TextInputAction.next,
            ),
            SuraNotifier(
              valueNotifier: isShowPasswordNotifier,
              builder: (bool isShowPassword) {
                return CustomTextField(
                  controller: passwordTC,
                  isObsecure: isShowPassword,
                  hint: "Password",
                  prefix: const Icon(AntDesign.lock, color: Colors.white),
                  suffix: !isShowPasswordNotifier.value
                      ? IconButton(
                          onPressed: () {
                            isShowPasswordNotifier.value = !isShowPasswordNotifier.value;
                          },
                          icon: const Icon(FlutterIcons.eye_ent, color: Colors.white),
                        )
                      : IconButton(
                          onPressed: () {
                            isShowPasswordNotifier.value = !isShowPasswordNotifier.value;
                          },
                          icon: const Icon(FlutterIcons.eye_with_line_ent, color: Colors.white),
                        ),
                );
              },
            ),
            PrimaryButton(
              onPressed: onLogin,
              child: Text("login".toUpperCase()),
            ),
            const SpaceY(),
          ],
        ),
      ),
    );
  }

  Widget buildCreateAccount() {
    return SuraFlatButton(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          Text(
            "Don't have account yet?",
            style: kSubHeaderStyle.normal.white,
          ),
          const SpaceX(4),
          Text(
            "Create now",
            style: kSubHeaderStyle.normal.white,
          ),
        ],
      ),
      onPressed: () => PageNavigator.push(context, const RegisterPage()),
    );
  }
}
