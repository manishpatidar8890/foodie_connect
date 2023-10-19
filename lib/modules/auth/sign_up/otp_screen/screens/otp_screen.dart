import 'package:flutter/gestures.dart';
import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../routes/routes_export.dart';
import '../provider/otp_provider.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  const OtpScreen({
    super.key,required this.email
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var otpController = TextEditingController();
  final CountdownController _controller = CountdownController(autoStart: true);
  @override
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
        child: Consumer<OtpProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalStrings.enterOTP,
                  style: AppStyle.loginTitleTextStyle,
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: LocalStrings.pleaseEnterOTPWhich,
                      style: AppStyle.pleaseEnterOtpWhich,
                      children: <TextSpan>[
                        TextSpan(
                          text: "\"xxxxx@mail.com\"",
                          style: AppStyle.emailAddress,
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppDimens.height20,
                ),
                Text(
                  LocalStrings.enterOTP,
                  style: AppStyle.signUPTextTextStyle,
                ),
                SizedBox(
                  height: AppDimens.height5,
                ),
                PinCodeTextField(
                  autofocus: true,
                  controller: otpController,
                  hideCharacter: false,
                  highlight: true,
                  defaultBorderColor:Colors.grey,
                  hasTextBorderColor: Colors.black,
                  onDone: (value) {
                  },
                  onTextChanged: (value) {

                  },
                  pinBoxWidth: AppDimens.width50,
                  pinBoxHeight: AppDimens.height50,
                  hasUnderline: false,
                  focusNode: FocusNode(),
                  wrapAlignment: WrapAlignment.spaceEvenly,
                  pinBoxDecoration:
                      ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                  pinTextStyle: AppStyle.pinCodeStyle,
                  pinTextAnimatedSwitcherTransition:
                      ProvidedPinBoxTextAnimation.scalingTransition,
                  pinBoxRadius: AppDimens.radius10,
                  pinTextAnimatedSwitcherDuration:
                      const Duration(milliseconds: 300),
                  highlightAnimationBeginColor: Colors.black,
                  highlightAnimationEndColor: Colors.black,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: AppDimens.height30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LocalStrings.didNotReceivedOtp,
                      style: AppStyle.pleaseEnterOtpWhich,
                    ),
                    ValueListenableBuilder(
                      valueListenable: provider.showResendButton,
                      builder: (BuildContext context, bool value, Widget? child) {
                        return Row(
                          children: [
                            Countdown(
                              controller: _controller,
                              seconds: 30,
                              build: (_, double time) => Text(time.toString(),
                                  style: AppStyle.counterTimer),
                              interval: const Duration(seconds: 1),
                              onFinished: () {
                                provider.setResendValue(true);
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text('Timer is done!'),
                                //   ),
                                // );
                              },
                            ),
                            Text(
                              LocalStrings.secLeft,
                              style: AppStyle.pleaseEnterOtpWhich,
                            )
                          ],
                        );
                      },

                    )
                  ],
                ),
                ValueListenableBuilder(
                  valueListenable: provider.showResendButton,
                  builder: (context, value, child) {
                    return value
                        ? InkWell(
                            onTap: () {
                              provider.setResendValue(false);
                              _controller.restart();
                            },
                            child: Text(
                              LocalStrings.reSendOTP,
                              style: AppStyle.counterTimer,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
                const Spacer(),
                RoundButton(
                    color: Colors.transparent,
                    textColor: AppColors.color000000,
                    text: LocalStrings.verifyButtonText,
                    onPressedFunction: () {
                      String otp=otpController.text.trim();
                      if (otp.isEmpty) {
                        FlushBarMessage.flushBarBottomErrorMessage(
                            message: LocalStrings.pleaseEnterOTPWhich,
                            context: context);
                      } else {
                        provider.emailVerifyApi(otp: otp, email: widget.email.toString(), context: context);
                      }
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
