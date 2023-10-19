import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodie_connect/network/models/response/scan_qr/scan_qr.dart';

import '../../../../core_utils/flush_bar_message.dart';
import '../../../../core_utils/toasts.dart';
import '../../../../logger/app_logger.dart';
import '../../../../network/NetworkUrls/app_network_urls.dart';
import '../../../../network/models/request/scanner/scanQr.dart';
import '../../../../network/repositories/auth_repository.dart';
import '../../../../routes/route_name.dart';

class QrProvider extends ChangeNotifier{
int scanCount=0;
setScanCount(int value){
  scanCount=value;
  notifyListeners();
}
  Future<void> qrUpdateApi(
      {required String qrCode,
        String? username,
        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        ScanQrRequest data =
        ScanQrRequest(userName: username,qrCode:qrCode );
        logD("loginApi Request : ${data.toJson()}");

        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .qrUpDateApi(
            data: data, url: AppNetworkUrls.qrUpdateApi)
            .then((value) {
          final validationResponse = ScanQrResponse.fromJson(value);
          logD("UILoginHit: $validationResponse");
          if (validationResponse.success == false) {
            Toasts.getErrorToast(text: validationResponse.message);
            logD("error message: ${validationResponse.message}");
          } else {
            Toasts.getSuccessToast(text: validationResponse.message);
            setScanCount(validationResponse.data!.totalScanned!);
            notifyListeners();
            Navigator.pushNamed(context, RouteName.qrDetailScreen);
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

}