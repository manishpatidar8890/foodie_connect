import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core_utils/toasts.dart';
import '../../../logger/app_logger.dart';
import '../../../network/NetworkUrls/app_network_urls.dart';
import '../../../network/models/request/auth/complete_Influencer_profile.dart';
import '../../../network/models/request/deals/create_deals.dart';
import '../../../network/models/response/create_deals/create_deal_response.dart';
import '../../../network/models/response/create_deals/create_deals.dart';
import '../../../network/repositories/auth_repository.dart';
import '../../../routes/route_name.dart';
import '../../../widgets/custom_loader.dart';

class CreateProvider extends ChangeNotifier {
  XFile? createImage;
  List<Datum> searchInfluencer = [];
  List<Datum> addInfluencer = [];
  bool isLoading = false;
  bool isExclusive= false;
  setCreateDealImage(XFile value) {
    createImage = value;
    notifyListeners();
  }

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  setIsExclusive(bool value) {
    isExclusive = value;
    notifyListeners();
  }
  setSearchInfluencer(List<Datum> value) {
    for (var element in value) {
      searchInfluencer.add(element);
    }
    notifyListeners();
  }
  setAddInfluencer(Datum value) {
      addInfluencer.add(value);

    notifyListeners();
  }
setRemoveInfluencer(int index){
    addInfluencer.removeAt(index);
    notifyListeners();
}
  Future<void> searchDealsPublish(
      {
      required searchText,}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        setIsLoading(true);
        notifyListeners();
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .searchInfluencer(url: AppNetworkUrls.searchInfluencer, params: searchText)
            .then((value) async {
          final searchResponse = SearchInfluencerResponse.fromJson(value);
          logD("UILoginHit: $searchResponse");

          if (searchResponse.success == false) {
            logD("error message: ${searchResponse.message}");
            // Navigator.pop(context);
            setIsLoading(false);
            notifyListeners();
            Toasts.getErrorToast(text: searchResponse.message);
          } else {
            // Navigator.pop(context);
            logD("api response: ${searchResponse.message}");
            searchInfluencer.clear();
            notifyListeners();
            await setSearchInfluencer(searchResponse.data!);
            notifyListeners();
            setIsLoading(false);
            notifyListeners();
            // Toasts.getSuccessToast(text: searchResponse.message);
          }
        }).onError((error, stackTrace) {
          // Navigator.pop(context);
          setIsLoading(false);
          notifyListeners();
          Toasts.getErrorToast(text: error.toString());
        });
      } else {
        Toasts.getWarningToast(text: "No internet connection available");
      }
    });
  }




  Future<void> completeInfluencerProfile(
      {
        required String title,
        required String amount,
        required String customer_bonus,
        required String customer_fee,
        required String description,
        required String end_date,
        required String influencer_id,
        required String is_exclusive_deal,
        required String start_date,
        required bool published,


        required BuildContext context}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        CustomLoader.fetchData(context);
        CreateDealRequest data = CreateDealRequest(title: title,amount: amount,customer_bonus: customer_bonus,customer_fee:customer_fee ,description: description,end_date: end_date,influencer_id:influencer_id ,is_exclusive_deal:is_exclusive_deal ,published:published ,start_date:start_date);
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .createDealsApi(
            url: AppNetworkUrls.createDeal,
            request: data,
            image: createImage)
            .then((value) {
          final profileResponse = CreateDealResponse.fromJson(value);
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
}
