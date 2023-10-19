import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/modules/auth/forget_password/provider/forget_password_provider.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../../../../core_utils/flush_bar_message.dart';

class NewPasswordScreen extends StatefulWidget {
  final String? email;
  final String? otp;
  const NewPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController nPasswordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.verifyOtp,
          style: AppStyle.loginTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<ForgetPasswordProvider>(
            builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppDimens.height20,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: provider.passObscureTextValue,
                    builder: (context, value, child) {
                      return FormFieldWithPrefixIcon(
                        obscureText: value,
                        controller: nPasswordController,
                        focusNode: FocusNode(),
                        hintText: LocalStrings.enterNewPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureValue: value ? true : false,
                        color: AppColors.primaryColor,
                        passwordFilled: true,
                        callBackFunction: () {
                          provider.setPassObscureText(!value);
                        },
                        textInputAction: TextInputAction.done,
                        label: LocalStrings.enterPassword,
                      );
                    }),
                SizedBox(
                  height: AppDimens.height20,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: provider.confirmPassObscureTextValue,
                    builder: (context, value, child) {
                      return FormFieldWithPrefixIcon(
                        obscureText: value,
                        controller: cPasswordController,
                        focusNode: FocusNode(),
                        hintText: LocalStrings.confirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureValue: value ? true : false,
                        color: AppColors.primaryColor,
                        passwordFilled: true,
                        callBackFunction: () {
                          provider.setConfirmPassObscureText(!value);
                        },
                        textInputAction: TextInputAction.done,
                        label: LocalStrings.enterPassword,
                      );
                    }),
                const Spacer(),
                Consumer(
                  builder: (BuildContext context, value, Widget? child) {
                    return RoundButton(
                        color: Colors.transparent,
                        textColor: AppColors.color000000,
                        text: LocalStrings.setPasswordButtonText,
                        onPressedFunction: () {
                          String newPassword = nPasswordController.text.trim();
                          String confirmPassword =
                              cPasswordController.text.trim();
                          if (newPassword != confirmPassword) {
                            FlushBarMessage.flushBarBottomErrorMessage(
                                message: LocalStrings.passwordDoesNotMatched,
                                context: context);
                          } else if (newPassword.isEmpty &&
                              confirmPassword.isEmpty) {
                            FlushBarMessage.flushBarBottomErrorMessage(
                                message: LocalStrings.pleaseEnterCredential,
                                context: context);
                          } else if (confirmPassword.isEmpty) {
                            FlushBarMessage.flushBarBottomErrorMessage(
                                message:
                                    LocalStrings.pleaseEnterConfirmPassword,
                                context: context);
                          } else if (newPassword.isEmpty) {
                            FlushBarMessage.flushBarBottomErrorMessage(
                                message: LocalStrings.pleaseEnterNewPassword,
                                context: context);
                          } else {
                            provider.resetPasswordApi(
                                email: widget.email.toString(),
                                context: context,
                                newPassword: nPasswordController.text);
                          }
                        });
                  },
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
