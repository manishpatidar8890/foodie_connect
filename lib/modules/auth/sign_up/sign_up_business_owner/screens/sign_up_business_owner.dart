import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../../sign_up_influencer/sign_up_provider/sign_up_provider.dart';

class SignUpBusinessOwnerScreen extends StatefulWidget {
  const SignUpBusinessOwnerScreen({
    super.key,
  });

  @override
  State<SignUpBusinessOwnerScreen> createState() =>
      _SignUpBusinessOwnerScreenState();
}

class _SignUpBusinessOwnerScreenState extends State<SignUpBusinessOwnerScreen> {
  TextEditingController nameBusinessController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.signUp,
          style: AppStyle.loginTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<SignUpProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalStrings.welcomeToTheFoodiesConnect,
                    style: AppStyle.welcomeToTheFoodiesConnectStyle,
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: nameBusinessController,
                    hintText: LocalStrings.emailBusinessName,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: emailController,
                    onChanged: (value){
                      provider.checkEmailUsername(type:"email",value:emailController.text, context: context);
                    },
                    hintText: LocalStrings.enterEmail,
                    focusNode: FocusNode(),
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  FormFieldWithPrefixIcon(
                    controller: userController,
                    hintText: LocalStrings.enterUserName,
                    focusNode: FocusNode(),
                    onChanged: (p0) {
                      provider.checkEmailUsername(type:"user_name",value:userController.text, context: context);
                    },
                  ),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  ValueListenableBuilder<bool>(
                      valueListenable: provider.passObscureTextValue,
                      builder: (context, value, child) {
                        return FormFieldWithPrefixIcon(
                          obscureText: value,
                          controller: passwordController,
                          focusNode: FocusNode(),
                          hintText: LocalStrings.enterPassword,
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
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                  RoundButton(
                      color: Colors.transparent,
                      textColor: AppColors.color000000,
                      text: LocalStrings.next,
                      onPressedFunction: () {
                        // Navigator.pushNamed(context, RouteName.otpScreen);
                        String email = emailController.text.trim();
                        var password = passwordController.text.trim();
                        var businessName = nameBusinessController.text.trim();
                        var userName = userController.text.trim();
                        var confirmPassword =
                        cPasswordController.text.trim();
                        if (email.isEmpty &&
                            password.isEmpty &&
                            businessName.isEmpty &&
                            userName.isEmpty &&
                            confirmPassword.isEmpty) {
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterCredential,
                              context: context);
                        }else if(businessName.isEmpty){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterBusinessName,
                              context: context);
                        }else if(email.isEmpty ){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterEmail,
                              context: context);
                        }else if( userName.isEmpty  ){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterUserName,
                              context: context);
                        }else if(password.isEmpty  ){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterPassword,
                              context: context);
                        }else if( confirmPassword.isEmpty ){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.pleaseEnterConfirmPassword,
                              context: context);
                        }else if( confirmPassword != password ){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: LocalStrings.passwordDoesNotMatched,
                              context: context);
                        }else if(provider.checkUser.value == false){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: "Username Already exist !",
                              context: context);
                        }else if(provider.checkEmail != "valid"){
                          FlushBarMessage.flushBarBottomErrorMessage(
                              message: "Email Already exist !",
                              context: context);
                        }
                        else{
                          provider.signupBusinessApi(email: email,password: password,businessName: businessName,userName: userName,
                               context: context);
                        }
                      }),
                  SizedBox(
                    height: AppDimens.height20,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
