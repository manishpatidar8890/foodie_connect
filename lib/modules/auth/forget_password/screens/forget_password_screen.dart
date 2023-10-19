import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/modules/auth/forget_password/provider/forget_password_provider.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../../../../core_utils/toasts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.forgotPassword,
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
                FormFieldWithPrefixIcon(
                  controller: emailController,
                  hintText: LocalStrings.emailOrUsername,
                  focusNode: FocusNode(),
                ),
                const Spacer(),
                RoundButton(
                    color: Colors.transparent,
                    textColor: AppColors.color000000,
                    text: LocalStrings.next,
                    onPressedFunction: () {
                      String email=emailController.text.trim();
                      if(email.isEmpty){
                        Toasts.getErrorToast(text: LocalStrings.pleaseEnterEmail);
                      }else{
                        provider.forgetOtpApi(email: email, context: context);
                        provider.setResendValue(false);
                      }

                    }),
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
