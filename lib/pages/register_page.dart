import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/api_service/index.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/pages/category_page.dart';
import 'package:where_the_food/service/auth_service.dart';
import 'package:where_the_food/utils/app_utils.dart';
import 'package:where_the_food/utils/custom_form_validator.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/custom_text_field.dart';
import 'package:where_the_food/widgets/primary_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SuraFormMixin {
  late TextEditingController userNameTC;
  late TextEditingController fullNameTC;
  late TextEditingController birthDayTC;
  late TextEditingController passwordTC;
  late TextEditingController confirmPasswordTC;
  late ValueNotifier<bool> isShowPasswordNotifier;
  late ValueNotifier<bool> isShowConfirmPasswordNotifier;
  DateTime? selectedDate;
  DateTime? lastDate;

  Future<void> onRegister() async {
    if (isFormValidated) {
      FocusScope.of(context).unfocus();
      String username = userNameTC.text.trim();
      String password = passwordTC.text.trim();
      try {
        toggleLoading();
        await authApiService.registerUser(
          fullName: fullNameTC.text.trim(),
          username: userNameTC.text.trim(),
          password: passwordTC.text.trim(),
          dateOfBirth: selectedDate!.formatDate(format: "yyyy-MM-dd"),
        );

        final authResponse = await authApiService.loginUser(
          username: username,
          password: password,
        );
        await AuthService.onLoginSuccess(context, authResponse);
        PageNavigator.pushAndRemove(context, const CategoryPage());
      } catch (exception) {
        toastMessageError(exception.toString(), context);
      } finally {
        toggleLoading();
      }
    }
  }

  @override
  void initState() {
    userNameTC = TextEditingController(text: "");
    fullNameTC = TextEditingController(text: "");
    passwordTC = TextEditingController(text: "");
    birthDayTC = TextEditingController(text: "");
    confirmPasswordTC = TextEditingController(text: "");
    isShowPasswordNotifier = ValueNotifier(true);
    isShowConfirmPasswordNotifier = ValueNotifier(true);
    super.initState();
  }

  @override
  void dispose() {
    userNameTC.dispose();
    fullNameTC.dispose();
    passwordTC.dispose();
    birthDayTC.dispose();
    confirmPasswordTC.dispose();
    isShowPasswordNotifier.dispose();
    isShowConfirmPasswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: AppColor.gradientColors,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildForm(),
                  buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "REGISTER",
              style: kSubHeaderStyle.white,
            ),
            const SpaceY(),
            CustomTextField(
              controller: userNameTC,
              hint: "User Name",
              prefix: const Icon(AntDesign.user, color: Colors.white),
            ),
            CustomTextField(
              controller: fullNameTC,
              hint: "Full Name",
              prefix: const Icon(AntDesign.user, color: Colors.white),
            ),
            CustomTextField(
              controller: birthDayTC,
              hint: "Date of Birth",
              onTap: () async {
                selectedDate = await AppUtils.onPickDOB(lastDate, birthDayTC, context);
              },
              prefix: const Icon(FlutterIcons.calendar_month_mco, color: Colors.white),
            ),
            SuraNotifier(
              valueNotifier: isShowPasswordNotifier,
              builder: (bool isShowPassword) {
                return CustomTextField(
                  controller: passwordTC,
                  isObsecure: isShowPassword,
                  validator: (value) => FormValidator.validateField(value, "Password", length: 8),
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
            SuraNotifier(
              valueNotifier: isShowConfirmPasswordNotifier,
              builder: (bool isShowConfirmPassword) {
                return CustomTextField(
                  isObsecure: isShowConfirmPassword,
                  controller: confirmPasswordTC,
                  validator: (value) => FormValidator.validateConfirmPassword(value, passwordTC.text.trim()),
                  hint: "Confirm Password",
                  prefix: const Icon(AntDesign.lock, color: Colors.white),
                  suffix: !isShowConfirmPasswordNotifier.value
                      ? IconButton(
                          onPressed: () {
                            isShowConfirmPasswordNotifier.value = !isShowConfirmPasswordNotifier.value;
                          },
                          icon: const Icon(FlutterIcons.eye_ent, color: Colors.white),
                        )
                      : IconButton(
                          onPressed: () {
                            isShowConfirmPasswordNotifier.value = !isShowConfirmPasswordNotifier.value;
                          },
                          icon: const Icon(FlutterIcons.eye_with_line_ent, color: Colors.white),
                        ),
                );
              },
            ),
            PrimaryButton(
              onPressed: onRegister,
              child: const Text(
                "REGISTER",
                style: kSubtitleStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    return SuraFlatButton(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        children: [
          Text(
            "Already have account?",
            style: kSubHeaderStyle.normal.white,
          ),
          const SpaceX(4),
          Text(
            "Sign in",
            style: kSubHeaderStyle.normal.white,
          ),
        ],
      ),
      onPressed: () => PageNavigator.pop(context),
    );
  }
}
