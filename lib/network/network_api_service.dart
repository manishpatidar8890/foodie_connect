import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../core_utils/toasts.dart';
import '../logger/app_logger.dart';
import 'app_exception.dart';
import 'base_api_services.dart';

class NetworkApiService extends BaseApiServices {
  final _dio = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(minutes: 1), // 1 minutes
    receiveTimeout: const Duration(minutes: 1), // 1 minutes
  ));

  static final NetworkApiService _apiServiceInstance = NetworkApiService();

  static NetworkApiService get apiServicesInstance => _apiServiceInstance;

  NetworkApiService() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }
  @override
  Future callGetApiResponse(
      {required String url,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) async {
    try {
      // Dio Certificate Callback
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        //  call here
        Response response = await _dio.get(url,
            options: Options(headers: myHeaders), queryParameters: parameters);

        return returnSuccessResponse(response);
      } else {
        Toasts.getWarningToast(text: "No Internet Connection Available :(");
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      logD("OnGetError: $ex");
    } on Exception {
      logD("badHappenedError");
    }
  }

  @override
  Future callPostApiResponse(
      {required String url,
      required dynamic body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) async {
    try {
      // Dio Certificate Callback
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        //  call here

        Response response = await _dio.post(url,
            options: Options(headers: myHeaders),
            data: body,
            queryParameters: parameters);
        return returnSuccessResponse(response);
      } else {
        Toasts.getWarningToast(text: "No Internet Connection Available :(");
      }
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      logD("OnPostError: $ex");
    } on Exception {
      logD("badHappenedError");
    }
  }

  @override
  Future callDeleteApiResponse(
      {required String url,
      required body,
      Map<String, dynamic>? parameters,
      Map<String, dynamic>? myHeaders}) async {
    try {
      // Dio Certificate Callback
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        //  call here

        Response response = await _dio.delete(url,
            options: Options(headers: myHeaders),
            data: body,
            queryParameters: parameters);
        return returnSuccessResponse(response);
      } else {
        Toasts.getWarningToast(text: "No Internet Connection Available :(");
      }
    } on DioException catch (e) {
      logD("onDeleteError: $e");
    } on Exception {
      logD("badHappenedError");
    }
  }

  @override
  Future callPutApiResponse(
      {required String url,
      required body,
      Map<String, dynamic>? parameters,
      Options? options,
      Map<String, dynamic>? myHeaders}) async {
    try {
      // Dio Certificate Callback
      (_dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult != ConnectivityResult.none) {
        //  call here
        Response response = await _dio.put(url,
            options: options, data: body, queryParameters: parameters);

        return returnSuccessResponse(response);
      } else {
        Toasts.getWarningToast(text: "No Internet Connection Available :(");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        var response = e.response;
        return returnErrorResponse(response!);
      }
      logD("onPutError: $e");
    } on Exception {
      logD("badHappenedError");
    }
  }

  // Check Response Status and Return Data in Success
  dynamic returnSuccessResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        // dynamic responseJson = jsonDecode(response.data);
        // logD("responseJson: $responseJson");
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorisedException(response.data.toString());
      case 403:
        throw ForbiddenException(response.data.toString());
      case 404:
        throw NotFoundException(response.data.toString());
      case 500:
        throw InternalServerError(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code${response.statusCode}');
    }
  }

  // Check Response Status and Return Data in Failure
  dynamic returnErrorResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.data);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
        throw UnauthorisedException(response.data.toString());
      case 403:
        throw ForbiddenException(response.data.toString());
      case 404:
        throw NotFoundException(response.data.toString());
      case 500:
        throw InternalServerError(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with server with status code${response.statusCode}');
    }
  }
}
