import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:foodie_connect/network/models/response/auth/email_verify_response.dart';

import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/toasts.dart';
import '../../../../../local_store/shared_preference.dart';
import '../../../../../logger/app_logger.dart';
import '../../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../../network/models/request/auth/emil_verification_request.dart';
import '../../../../../network/models/response/common_response.dart';
import '../../../../../network/repositories/auth_repository.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../widgets/custom_loader.dart';

class OtpProvider extends ChangeNotifier {
  ValueNotifier<bool> showResendButton = ValueNotifier(false);
  setResendValue(value) {
    showResendButton.value = value;
    notifyListeners();
  }

  // ==================================== register Email verify ====================

  Future<void> emailVerifyApi(
      {required String email,
        otp,
        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        EmailVerificationRequest data = EmailVerificationRequest(
          email: email,
          otpCode: otp,
        );
        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authRegisterApi(
            data: data, url: AppNetworkUrls.verifyRegisterOtp)
            .then((value) {
          final emailVerifyResponse =
          EmailVerifyResponse.fromJson(value);
          logD("UILoginHit: $emailVerifyResponse");
          if (emailVerifyResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: emailVerifyResponse.message);
            logD("error message: ${emailVerifyResponse.message}");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              PreferenceUtils.setAccessToken(emailVerifyResponse.accessToken!);
              PreferenceUtils.setUserType(emailVerifyResponse.data!.userType.toString());
              Navigator.pop(context);
              Toasts.getSuccessToast(text: emailVerifyResponse.message);
              Navigator.pushReplacementNamed(context, RouteName.emailVerifySuccessScreen,arguments: email);
            });
          }
        }).onError((error, stackTrace) {
          Navigator.pop(context);
          FlushBarMessage.flushBarBottomErrorMessage(
              message: error.toString(), context: context);
        });
      } else {
        Toasts.getWarningToast(text: "No internet connection available");
      }
    });
  }
}
