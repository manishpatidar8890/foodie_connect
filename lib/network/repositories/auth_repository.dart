import 'package:dio/dio.dart';
import 'package:foodie_connect/core_utils/toasts.dart';
import 'package:image_picker/image_picker.dart';

import '../../local_store/shared_preference.dart';
import '../../logger/app_logger.dart';
import '../models/request/auth/complete_Influencer_profile.dart';
import '../models/request/auth/complete_business_profile.dart';
import '../models/request/deals/create_deals.dart';
import '../network_api_service.dart';

class AuthRepository {
  // Generate Instance
  static final AuthRepository _authRepository = AuthRepository();

  // Get Instance of the class.
  static AuthRepository get authRepositoryInstance => _authRepository;
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future<dynamic> authLoginApi(
      {required dynamic data, required String url}) async {
    logD("authLoginApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authLoginApiError: $e");
    }
  }

  Future<dynamic> validateEmailUserNameApi(
      {required dynamic data, required String url}) async {
    logD("authLoginApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authLoginApiError: $e");
    }
  }

  Future<dynamic> authRegisterApi(
      {required dynamic data, required String url}) async {
    logD("authRegisterApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authRegisterApiError: $e");
    }
  }

  Future<dynamic> completeProfileApi({
    required CompleteInfluencerProfileRequest request,
    XFile? image,
    required String url,
  }) async {
    try {
      var token = PreferenceUtils.getAccessToken() ?? "";
      Map<String, String> headerWithToken = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      MultipartFile? photo;
      if (image != null) {
        photo = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      FormData formData =
          FormData.fromMap({"image": photo, ...request.toJson()});
      // FormData formData = FormData.fromMap({...request.toJson()});

      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(
              url: url, body: formData, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      Toasts.getErrorToast(text: e.toString());
    }
  }
  Future<dynamic> createDealsApi({
    required CreateDealRequest request,
    XFile? image,
    required String url,
  }) async {
    try {
      var token = PreferenceUtils.getAccessToken() ?? "";
      Map<String, String> headerWithToken = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      MultipartFile? photo;
      if (image != null) {
        photo = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      FormData formData =
          FormData.fromMap({"image": photo, ...request.toJson()});
      // FormData formData = FormData.fromMap({...request.toJson()});

      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(
              url: url, body: formData, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      Toasts.getErrorToast(text: e.toString());
    }
  }
  Future<dynamic> completeBusinessProfileApi({
    required CompleteBusinessProfileRequest request,
    XFile? image,
    required String url,
  }) async {
    try {
      var token = PreferenceUtils.getAccessToken() ?? "";
      Map<String, String> headerWithToken = {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token'
      };

      MultipartFile? photo;
      if (image != null) {
        photo = await MultipartFile.fromFile(image.path, filename: image.name);
      }
      FormData formData =
      FormData.fromMap({"image": photo, ...request.toJson()});
      // FormData formData = FormData.fromMap({...request.toJson()});

      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(
          url: url, body: formData, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      Toasts.getErrorToast(text: e.toString());
    }
  }
  Future<dynamic> searchUserNameApi(
      {required dynamic data, required String url}) async {
    logD("authRegisterApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authRegisterApiError: $e");
    }
  }

  Future<dynamic> checkUserStatusApi(
      {required dynamic data, required String url}) async {
    logD("authRegisterApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authRegisterApiError: $e");
    }
  }

  Future<dynamic> authVerifyOTPApi(
      {required dynamic data, required String url}) async {
    logD("authVerifyOTPApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> verifyOTPViaEmailApi(
      {required dynamic data, required String url}) async {
    logD("authVerifyOTPApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> authResetPasswordApi(
      {required dynamic data, required String url}) async {
    logD("authResetPasswordApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authResetPasswordApiError: $e");
    }
  }

  Future<dynamic> forgotPasswordApi(
      {required String url, required data}) async {
    logD("authVerifyOTPApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> searchDealApi(
      {required String url, required data}) async {
    logD("authVerifyOTPApi url : $url");
    var token = PreferenceUtils.getAccessToken() ?? "";
    Map<String, String> headerWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }




  Future<dynamic> qrUpDateApi(
      {required String url, required data}) async {
    logD("authVerifyOTPApi url : $url");
    var token = PreferenceUtils.getAccessToken() ?? "";
    Map<String, String> headerWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> resendOtpViaEmailApi(
      {required String url, required data}) async {
    logD("authVerifyOTPApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> publishDeal({required String url,})async{
    logD("authVerifyOTPApi url : $url");
    var token = PreferenceUtils.getAccessToken() ?? "";
    Map<String, String> headerWithToken = {
      'Authorization': 'Bearer $token'
    };
    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callGetApiResponse(url: url, myHeaders: headerWithToken);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }

  Future<dynamic> searchInfluencer(
      {required String url,required params}) async {
    logD("authVerifyOTPApi url : $url");
    var token = PreferenceUtils.getAccessToken() ?? "";
    Map<String, String> headerWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    Map<String, String>param = {
      'keywords': params,
    };
    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callGetApiResponse(url: url, myHeaders: headerWithToken, parameters:param );
      return response;
    } catch (e) {
      logD("search Influencer Error: $e");
    }
  }
  Future<dynamic> updatePasswordApi(
      {required String url, required data}) async {
    logD("authVerifyOTPApi url : $url");

    try {
      dynamic response = await NetworkApiService.apiServicesInstance
          .callPostApiResponse(url: url, body: data, myHeaders: headers);
      return response;
    } catch (e) {
      logD("authVerifyOTPApiError: $e");
    }
  }
}
