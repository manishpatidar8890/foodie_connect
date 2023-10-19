import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:foodie_connect/core_utils/app_image.dart';
import 'package:foodie_connect/local_store/shared_preference.dart';
import 'package:foodie_connect/network/models/request/auth/complete_business_profile.dart';
import 'package:foodie_connect/network/models/request/auth/signup_business_request.dart';
import 'package:foodie_connect/network/models/response/common_response.dart';
import 'package:foodie_connect/routes/routes_export.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core_utils/flush_bar_message.dart';
import '../../../../../core_utils/toasts.dart';
import '../../../../../logger/app_logger.dart';
import '../../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../../network/models/request/auth/complete_Influencer_profile.dart';
import '../../../../../network/models/request/auth/signup_influencer_request.dart';
import '../../../../../network/models/request/auth/validate_email_username.dart';
import '../../../../../network/models/response/auth/signup_influencer_response.dart';
import '../../../../../network/repositories/auth_repository.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../widgets/custom_loader.dart';

class SignUpProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  ValueNotifier<bool> passObscureTextValue = ValueNotifier(true);
  ValueNotifier<bool> confirmPassObscureTextValue = ValueNotifier(true);
  ValueNotifier<bool> passObscureBusinessTextValue = ValueNotifier(true);
  ValueNotifier<bool> confirmPassObscureBusinessTextValue = ValueNotifier(true);
  ValueNotifier<bool> checkUser = ValueNotifier(false);
  String checkEmail = "valid";
  String? gender;
  XFile? influencerImage;
  XFile? businessImage;

  setPassObscureBusinessTextValue(bool value) {
    passObscureBusinessTextValue.value = value;
    notifyListeners();
  }
  setConfirmPassObscureBusinessTextValue(bool value) {
    confirmPassObscureBusinessTextValue.value = value;
    notifyListeners();
  } setPassObscureText(bool value) {
    passObscureTextValue.value = value;
    notifyListeners();
  }

  setGender(String value) {
    gender = value;
    notifyListeners();
  }

  setInfluencerImage(XFile value) {
    influencerImage = value;
    notifyListeners();
  }setBusinessImage(XFile value) {
    businessImage = value;
    notifyListeners();
  }

  setCheckUser(bool value) {
    checkUser.value = value;
    notifyListeners();
  }

  setCheckEmail(String value) {
    checkEmail = value;
    notifyListeners();
  }

  setConfirmPassObscureText(bool value) {
    confirmPassObscureTextValue.value = value;
    notifyListeners();
  }

  // ==================================== signup influencer ====================
  Future<void> signupInfluencerApi(
      {required String email,
      userName,
      password,
      firstName,
      lastName,
      required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        SignupInfluencerRequest data = SignupInfluencerRequest(
          email: email,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          password: password,
        );

        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authRegisterApi(
                data: data, url: AppNetworkUrls.signupInfluenceEndPint)
            .then((value) {
          final signupInfluencerResponse =
              SignupInfluencerResponse.fromJson(value);
          logD("UILoginHit: $signupInfluencerResponse");
          if (signupInfluencerResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: signupInfluencerResponse.message);
            logD("error message: ${signupInfluencerResponse.message}");
            if (signupInfluencerResponse.data != null) {
            } else {
              Navigator.pop(context);
              FlushBarMessage.flushBarBottomErrorMessage(
                  message: signupInfluencerResponse.message!, context: context);
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: signupInfluencerResponse.message);
              Navigator.pushNamed(context, RouteName.otpScreen,
                  arguments: email);
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
  // ==================================== complete influencer profile ====================

  Future<void> completeInfluencerProfile(
      {required String bio,
      required XFile? image,
      dateOfBirth,
      facebookLink,
      mobile,
      gender,
      youtubeLink,
      instagramLink,
      tiktokLink,
      required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        CompleteInfluencerProfileRequest data =
            CompleteInfluencerProfileRequest(
                bio: bio,
                dateOfBirth: dateOfBirth,
                facebookLink: facebookLink,
                gender: gender,
                instagramLink: instagramLink,
                mobile: mobile,
                tiktokLink: tiktokLink,
                youtubeLink: youtubeLink);
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .completeProfileApi(
                url: AppNetworkUrls.influencerProfile,
                request: data,
                image: influencerImage)
            .then((value) {
          final profileResponse = CommonResponse.fromJson(value);
          logD("UILoginHit: $profileResponse");
          if (profileResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: profileResponse.message);
            logD("error message: ${profileResponse.message}");
            // if (signupInfluencerResponse.data != null) {
            // } else {
            //   Navigator.pop(context);
            //   FlushBarMessage.flushBarBottomErrorMessage(
            //       message: signupInfluencerResponse.message!, context: context);
            // }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: profileResponse.message);
              Navigator.pushReplacementNamed(context, RouteName.bottomNavigationBarScreen);

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
  // ==================================== complete Business profile ====================

  Future<void> completeBusinessProfile(
      {required String address,
        required XFile? image,
        businessNumber,
        preferredNumber,
        website,

        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        CompleteBusinessProfileRequest data = CompleteBusinessProfileRequest(address: address,businessNumber: businessNumber,preferredNumber:preferredNumber ,website: website
           );
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .completeBusinessProfileApi(
            url: AppNetworkUrls.businessProfile,
            request: data,
            image: image)
            .then((value) {
          final profileResponse = CommonResponse.fromJson(value);
          logD("UILoginHit: $profileResponse");
          if (profileResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: profileResponse.message);
            logD("error message: ${profileResponse.message}");
            // if (signupInfluencerResponse.data != null) {
            // } else {
            //   Navigator.pop(context);
            //   FlushBarMessage.flushBarBottomErrorMessage(
            //       message: signupInfluencerResponse.message!, context: context);
            // }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: profileResponse.message);
              Navigator.pushReplacementNamed(context, RouteName.bottomNavigationBarScreen);
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
  // ==================================== check email / username  ====================

  Future<void> checkEmailUsername(
      {required String type,
      String? value,
      required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        ValidateEmailUserName data =
            ValidateEmailUserName(value: value, type: type);
        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .validateEmailUserNameApi(
                data: data, url: AppNetworkUrls.checkUniqueUser)
            .then((value) {
          final validationResponse = CommonResponse.fromJson(value);
          logD("UILoginHit: $validationResponse");
          if (validationResponse.success == false) {
            setCheckEmail(validationResponse.message.toString());
            setCheckUser(false);
            notifyListeners();
            Toasts.getErrorToast(text: validationResponse.message);
            logD("error message: ${validationResponse.message}");
          } else {
            setCheckEmail("valid");
            setCheckUser(true);
            notifyListeners();
          }
        }).onError((error, stackTrace) {
          Navigator.pop(context);
          FlushBarMessage.flushBarBottomErrorMessage(
              message: error.toString(), context: context);
          print("this");
        });
      } else {
        Toasts.getWarningToast(text: "No internet connection available");
      }
    });
  }

  // ==================================== signup business ====================

  Future<void> signupBusinessApi(
      {required String email,
      userName,
      password,
      businessName,
      required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        SignupBusinessRequest data = SignupBusinessRequest(
          email: email,
          businessName: businessName,
          password: password,
          userName: userName,
        );
        logD("loginApi Request : ${data.toJson()}");
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authRegisterApi(
                data: data, url: AppNetworkUrls.signupBusinessEndPint)
            .then((value) {
          final commonResponse = CommonResponse.fromJson(value);
          logD("UILoginHit: $commonResponse");
          if (commonResponse.success == false) {
            Navigator.pop(context);
            Toasts.getErrorToast(text: commonResponse.message);
            logD("error message: ${commonResponse.message}");
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
              Toasts.getSuccessToast(text: commonResponse.message);
              Navigator.pushNamed(context, RouteName.otpScreen,
                  arguments: email);
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
