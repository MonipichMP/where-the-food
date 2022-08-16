import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/constant/style.dart';
import 'package:where_the_food/utils/custom_form_validator.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final void Function(String?)? onSubmit;
  final bool isObsecure;
  final bool isPhoneNumber;
  final Widget? prefix;
  final Widget? suffix;
  final bool isRequired;
  final double marginBottom;
  final TextInputType textInputType;
  final double borderWidth;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final bool readOnly;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? style;
  final TextInputAction? textInputAction;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.validator,
    this.isObsecure = false,
    this.prefix,
    this.suffix,
    this.marginBottom = 16,
    this.textInputType = TextInputType.text,
    this.borderWidth = 0.8,
    this.isRequired = true,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.readOnly = false,
    this.onChange,
    this.onSubmit,
    this.isPhoneNumber = false,
    this.autoValidateMode,
    this.style,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: TextFormField(
        controller: controller,
        onChanged: onChange,
        onTap: onTap,
        readOnly: readOnly,
        obscureText: isObsecure,
        keyboardType: textInputType,
        textInputAction: textInputAction,
        validator: isRequired
            ? (value) {
                if (validator != null) return validator!(value);
                return FormValidator.validateField(value, hint);
              }
            : null,
        autocorrect: false,
        autovalidateMode: autoValidateMode,
        textCapitalization: textCapitalization,
        onFieldSubmitted: onSubmit,
        style: style ?? kTitleStyle.normal.white,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: kSubtitleStyle.white,
          prefixIcon: prefix,
          suffixIcon: suffix == null
              ? Icon(
                  FlutterIcons.asterisk_fou,
                  color: readOnly
                      ? AppColor.hintColor
                      : isRequired
                          ? Colors.red
                          : Colors.transparent,
                  size: 8,
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    suffix!,
                    const SpaceX(),
                    Icon(
                      FlutterIcons.asterisk_fou,
                      color: readOnly
                          ? AppColor.hintColor
                          : isRequired
                              ? Colors.red
                              : Colors.transparent,
                      size: 8,
                    ),
                    const SpaceX(16),
                  ],
                ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.hintColor, width: borderWidth),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: readOnly ? AppColor.hintColor : AppColor.primaryMaterial, width: borderWidth),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
    );
  }
}
