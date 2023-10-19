import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodie_connect/modules/auth/sign_up/sign_up_influencer/screens/complete_influencer_profile.dart';
import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/toasts.dart';
import '../../../../local_store/shared_preference.dart';
import '../../../../logger/app_logger.dart';
import '../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../network/models/response/auth/login_response.dart';
import '../../../../network/models/request/auth/login_request.dart';
import '../../../../network/repositories/auth_repository.dart';
import '../../../../routes/route_name.dart';
import '../../../../widgets/custom_loader.dart';
import '../../sign_up/sign_up_influencer/screens/complete_influencer_profile.dart';
import '../../sign_up/sign_up_influencer/screens/complete_influencer_profile.dart';

class LogInProvider extends ChangeNotifier {
  final AuthRepository authRepository = AuthRepository();
  ValueNotifier<bool> passObscureTextValue = ValueNotifier(true);
  ValueNotifier<bool> iAmAnInfluencer = ValueNotifier(true);
  ValueNotifier<bool> iAmABusinessOwner = ValueNotifier(false);

  setPassObscureText(bool value) {
    passObscureTextValue.value = value;
    notifyListeners();
  }

  setIAmAnInfluencer(bool value) {
    iAmAnInfluencer.value = value;
    notifyListeners();
  }

  setIAmABusinessOwner(bool value) {
    iAmABusinessOwner.value = value;
    notifyListeners();
  }



  Future<void> loginApi(
      {required String email,required String userType, password, required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        LoginRequest data = LoginRequest(
            emailOrUsername: email, password: password, userType: userType);
        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .authLoginApi(data: data, url: AppNetworkUrls.loginEndPint)
            .then((value) {
          final loginResponse = LoginResponse.fromJson(value);
          logD("UILoginHit: $loginResponse");
          if (loginResponse.success == false) {
            logD("error message: ${loginResponse.message}");
            if (loginResponse.isVerify==0){
              Navigator.pop(context);
              FlushBarMessage.flushBarBottomErrorMessage(
                  message: loginResponse.message!, context: context);
              Navigator.pushReplacementNamed(context, RouteName.otpScreen,
                  arguments: email);
            } else {
              Navigator.pop(context);
              FlushBarMessage.flushBarBottomErrorMessage(
                  message: loginResponse.message!, context: context);
            }
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              PreferenceUtils.setAccessToken(loginResponse.data!.accessToken!);
              PreferenceUtils.setUserType(loginResponse.data!.user!.userType.toString());
              Navigator.pop(context);
              Toasts.getSuccessToast(text: loginResponse.message);
              Navigator.pushReplacementNamed(context, RouteName.bottomNavigationBarScreen);

              // if(loginResponse.data!.user!.userType.toString()=="influencer"){
              //   Navigator.pushReplacementNamed(context, RouteName.completeInfluencerProfileScreen);
              // }else{
              //   Navigator.pushReplacementNamed(context, RouteName.completeBusinessProfileScreen);
              //
              // }
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
