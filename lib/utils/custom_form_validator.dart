class FormValidator {
  static String? validateField(String? value, String field, {int? length}) {
    if (value == null || value.isEmpty) return "Please input your $field.";
    if (length != null) {
      if (value.length < length) return "$field must have $length characters.";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Please input your email address.";
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
    return emailValid ? null : "Email is not valid";
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.trim().isEmpty) {
      return "Please input your confirm password.";
    }
    if (value != password) return "Password and Confirm password are not match each other.";
    return null;
  }
}
