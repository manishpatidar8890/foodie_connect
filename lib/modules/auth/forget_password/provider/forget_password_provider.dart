import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:foodie_connect/network/models/request/auth/reset_password_request.dart';
import 'package:foodie_connect/network/models/response/common_response.dart';

import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/toasts.dart';
import '../../../../logger/app_logger.dart';
import '../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../network/models/request/auth/forget_otp_request.dart';
import '../../../../network/models/request/auth/forget_otp_verify.dart';
import '../../../../network/models/request/auth/resend_otp_request.dart';
import '../../../../network/models/response/auth/signup_influencer_response.dart';
import '../../../../network/repositories/auth_repository.dart';
import '../../../../routes/route_name.dart';
import '../../../../widgets/custom_loader.dart';
import '../modal/arg_modal.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  ValueNotifier<bool> showResendButton = ValueNotifier(false);
  ValueNotifier<bool> passObscureTextValue = ValueNotifier(false);
  ValueNotifier<bool> confirmPassObscureTextValue = ValueNotifier(false);
  setResendValue(value) {
    showResendButton.value = value;
    notifyListeners();
  }
  setPassObscureText(bool value) {
    passObscureTextValue.value = value;
    notifyListeners();
  }
  setConfirmPassObscureText(bool value) {
    confirmPassObscureTextValue.value = value;
    notifyListeners();
  }
  // =========================== forget password =====================
  Future<void> forgetOtpApi(
      {required String email,
        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        ForgetOtpRequest data = ForgetOtpRequest(email: email);

        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .forgotPasswordApi(
            data: data, url: AppNetworkUrls.forgetPass)
            .then((value) {
          //    response model have to change
          final forgetPasswordResponse =
          CommonResponse.fromJson(value);
          logD("UILoginHit: $forgetPasswordResponse");
          if (forgetPasswordResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: forgetPasswordResponse.message);
            logD("error message: ${forgetPasswordResponse.message}");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: forgetPasswordResponse.message);
              Navigator.pushNamed(
                  context, RouteName.forgetPasswordOtpScreen,arguments: email);
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

  // =========================== resend otp ==========================


  Future<void> resendOtpApi(
      {required String email,

        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        ResendOtpRequest data = ResendOtpRequest(email: email);

        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .resendOtpViaEmailApi(
            data: data, url: AppNetworkUrls.resendOtp)
            .then((value) {
          //    response model have to change
          final resendResponse =
          CommonResponse.fromJson(value);
          logD("UILoginHit: $resendResponse");
          if (resendResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: resendResponse.message);
            logD("error message: ${resendResponse.message}");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: resendResponse.message);
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


  // =========================== forget Otp Verify Api =====================

  Future<void> forgetOtpVerifyApi(
      {
        required String otp,
        required String email,

        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        ForgetOtpVerifyRequest data = ForgetOtpVerifyRequest(otpCode: otp,email: email);

        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .resendOtpViaEmailApi(
            data: data, url: AppNetworkUrls.verifyForgetPasswordOTP)
            .then((value) {
          //    response model have to change
          final resendResponse =
          CommonResponse.fromJson(value);
          logD("UILoginHit: $resendResponse");
          if (resendResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: resendResponse.message);
            logD("error message: ${resendResponse.message}");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(
                  context, RouteName.newPasswordScreen,
                  arguments: NewPasswordArg(
                    email: email,
                    otpCode: otp,
                  ));
              Toasts.getSuccessToast(text: resendResponse.message);
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

  // =========================== reset pass  Api =====================

  Future<void> resetPasswordApi(
      {
        required String email,
        required String newPassword,

        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        ResetPasswordRequest data = ResetPasswordRequest(email: email,newPassword: newPassword);

        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .resendOtpViaEmailApi(
            data: data, url: AppNetworkUrls.changeForgetPassword)
            .then((value) {
          //    response model have to change
          final resetPassResponse =
          CommonResponse.fromJson(value);
          logD("UILoginHit: $resetPassResponse");
          if (resetPassResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: resetPassResponse.message);
            logD("error message: ${resetPassResponse.message}");

          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: resetPassResponse.message);
              Navigator.pushReplacementNamed(
                  context, RouteName.forgetPassSuccessScreen);
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
