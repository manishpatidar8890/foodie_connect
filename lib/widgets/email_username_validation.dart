import 'package:foodie_connect/modules/auth/sign_up/sign_up_influencer/sign_up_provider/sign_up_provider.dart';

class EmailUsernameValidation {
  EmailUsernameValidation._();

  static String? validation({
    SignUpProvider ? provider,
    String? value,
    String? message,
    bool isEmailValidator = false,
    bool isName = false,
  }) {
    if (value!.isEmpty) {
      return "$message is required!";
    } else if (isEmailValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {

        return 'Enter Valid $message';
      }
    } else if (isName == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (value.length > 30) {
        return '$message can\'t have more than 30 characters ';
      }
    }

    return null;
  }
}
