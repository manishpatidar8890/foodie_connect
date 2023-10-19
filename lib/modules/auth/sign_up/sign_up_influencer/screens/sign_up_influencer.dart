import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../../widgets/text_form_field_with_prefix_icon_label.dart';
import '../sign_up_provider/sign_up_provider.dart';

class SignUpInfluencerScreen extends StatefulWidget {
  const SignUpInfluencerScreen({
    super.key,
  });

  @override
  State<SignUpInfluencerScreen> createState() => _SignUpInfluencerScreenState();
}

class _SignUpInfluencerScreenState extends State<SignUpInfluencerScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  FocusNode confirmPasswordFocusNode =FocusNode();
  FocusNode passwordFocusNode =FocusNode();
  FocusNode firstNameFocusNode =FocusNode();
  FocusNode lastNameFocusNode =FocusNode();
  FocusNode emailFocusNode =FocusNode();
  FocusNode usernameFocusNode =FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.createAnAccount,
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
              child: Form(key:_formKey ,
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
                      controller: fNameController,
                      hintText: LocalStrings.enterFirstName,
                      focusNode: firstNameFocusNode,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      controller: lNameController,
                      hintText: LocalStrings.enterLastName,
                      focusNode:lastNameFocusNode,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      controller: emailController,
                      hintText: LocalStrings.enterEmail,
                      onComplete: (){
                      },
                      onChanged: (value){
                        provider.checkEmailUsername(type:"email",value:emailController.text, context: context);
                      },
                      // isEmail: true,
                      focusNode:emailFocusNode,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    ValueListenableBuilder(
                      valueListenable: provider.checkUser,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return FormFieldWithPrefixIcon(
                          controller: userController,
                          onComplete: () {
                          },
                          onChanged: (p0) {
                            provider.checkEmailUsername(type:"user_name",value:userController.text, context: context);
                          },
                          hintText: LocalStrings.enterUserName,
                          focusNode:usernameFocusNode,
                        );
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
                      height: AppDimens.height20,
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: provider.confirmPassObscureTextValue,
                        builder: (context, value, child) {
                          return FormFieldWithPrefixIcon(
                            obscureText: value,
                            controller: cPasswordController,
                            focusNode: confirmPasswordFocusNode,
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
                    Consumer<SignUpProvider>(
                      builder: (context, value, child) {
                        return RoundButton(
                            color: Colors.transparent,
                            textColor: AppColors.color000000,
                            text: LocalStrings.confirmButtonText,
                            onPressedFunction: () {
                              // Navigator.pushNamed(context, RouteName.otpScreen);
                              String email = emailController.text.trim();
                              var password = passwordController.text.trim();
                              var firstName = fNameController.text.trim();
                              var lastName = lNameController.text.trim();
                              var userName = userController.text.trim();
                              var confirmPassword =
                                  cPasswordController.text.trim();
                              if (email.isEmpty &&
                                  password.isEmpty &&
                                  firstName.isEmpty &&
                                  lastName.isEmpty &&
                                  userName.isEmpty &&
                                  confirmPassword.isEmpty) {
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterCredential,
                                    context: context);
                              }else if(firstName.isEmpty){
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterFirstName,
                                    context: context);
                              }else if( lastName.isEmpty ){
                                FlushBarMessage.flushBarBottomErrorMessage(
                                    message: LocalStrings.pleaseEnterLastName,
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
                              }else{
                                provider.signupInfluencerApi(email: email,password: password,
                                    userName: userName,firstName: firstName,lastName: lastName, context: context);
                              }
                            });
                      },
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
