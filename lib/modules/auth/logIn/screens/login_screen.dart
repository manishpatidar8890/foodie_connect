import 'package:flutter/gestures.dart';
import 'package:foodie_connect/routes/route_name.dart';
import '../../../../core_utils/export_dependency.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../routes/routes_export.dart';
import '../../../../widgets/round_button.dart';
import '../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../provider/login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.bgColor,
      body: SafeArea(
        bottom: false,
        child: Consumer<LogInProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      LocalStrings.welcomeToFoodies,
                      style: AppStyle.loginTitleTextStyle,
                    ),
                    Container(
                      height: AppDimens.height120,
                      margin: EdgeInsets.symmetric(horizontal: AppDimens.width20),
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.width20,
                          vertical: AppDimens.height20),
                      child: Center(
                        child: Image.asset(
                          AppImage.splashImage,
                        ),
                      ),
                    ),
                    // Text(
                    //   LocalStrings.getStarted,
                    //   style: AppStyle.loginTitleTextStyle,
                    // ),
                    SizedBox(height: AppDimens.height10),
                    FormFieldWithPrefixIcon(
                      controller: emailController,
                      hintText: LocalStrings.emailOrUsername,
                      focusNode: null,
                      image: AppImage.appLogo,
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
                            focusNode: passwordFocusNode,
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
                      height: AppDimens.height5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteName.forgetPasswordScreen);
                          },
                          child: Text(
                            LocalStrings.forgetPassword,
                            style: AppStyle.forgetPassword,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: provider.iAmAnInfluencer,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return InkWell(
                              onTap: () {
                                provider.setIAmAnInfluencer(true);
                                provider.setIAmABusinessOwner(false);
                              },
                              child: Container(
                                height: AppDimens.height20,
                                width: AppDimens.width20,
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color: value
                                //             ? Colors.transparent
                                //             : AppColors.greyColor)),
                                child:  Center(
                                  child:value? Icon(Icons.check_box,color: Colors.blueAccent,size: AppDimens.height20,
                                  ):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: AppDimens.height20
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: AppDimens.width20,),
                        Text(
                          LocalStrings.iAmAnInfluencer,
                          style: AppStyle.doNotHaveTextTextStyle,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: provider.iAmABusinessOwner,
                          builder: (BuildContext context, bool value,
                              Widget? child) {
                            return InkWell(
                              onTap: () {
                                provider.setIAmAnInfluencer(false);
                                provider.setIAmABusinessOwner(true);
                              },
                              child: Container(
                                height: AppDimens.height20,
                                width: AppDimens.width20,
                                // decoration: BoxDecoration(
                                //     border: Border.all(
                                //         color: value
                                //             ? Colors.transparent
                                //             : AppColors.greyColor)),
                                child:  Center(
                                  child:value? Icon(Icons.check_box,color: Colors.blueAccent,size: AppDimens.height20,
                               ):Icon(Icons.check_box_outline_blank,color: Colors.grey,size: AppDimens.height20
                                  ),
                                ),
                              ),
                            );

                          },
                        ), SizedBox(width: AppDimens.width20,),
                        Text(
                          LocalStrings.iAmABusinessOwner,
                          style: AppStyle.doNotHaveTextTextStyle,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppDimens.height30,
                    ),
                    ValueListenableBuilder(
                      valueListenable: provider.iAmAnInfluencer,
                      builder: (context, value, child) {
                        return RoundButton(
                          text: LocalStrings.loginButtonText,
                          onPressedFunction: () async {
                            FocusManager.instance.primaryFocus?.unfocus();
                            String email = emailController.text.trim();
                            var password = passwordController.text.trim();
                            if (_formKey.currentState!.validate()) {
                              if (provider.iAmAnInfluencer.value ==
                                  provider.iAmABusinessOwner.value) {
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterUserType,
                                    context: context);
                              } else if (email.isEmpty && password.isEmpty) {
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterCredential,
                                    context: context);
                              } else if (email.isEmpty) {
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message:
                                        LocalStrings.pleaseEnterUserNameOrEmail,
                                    context: context);
                              } else if (password.isEmpty) {
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterPassword,
                                    context: context);
                              } else {
                                provider.loginApi(
                                    email: email,
                                    password: password,
                                    context: context,
                                    userType: value ? "Influencer" : "Business Owner");
                              }
                            } else {}
                          },
                          color: Colors.transparent,
                          textColor: AppColors.color000000,
                        );
                      },
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),

                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: LocalStrings.doNotHaveAnAccount,
                          style: AppStyle.doNotHaveTextTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                              text: LocalStrings.createAccount,
                              style: AppStyle.createAccount,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, RouteName.userTypeScreen);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
