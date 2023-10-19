import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodie_connect/network/models/request/deals/search_deals.dart';

import '../../../core_utils/toasts.dart';
import '../../../logger/app_logger.dart';
import '../../../network/NetworkUrls/app_network_urls.dart';
import '../../../network/models/response/publish/exclusive_deals_response.dart';
import '../../../network/models/response/publish/owner_publish_public_deals.dart';
import '../../../network/models/response/publish/search_response.dart';
import '../../../network/repositories/auth_repository.dart';

class DealsProvider extends ChangeNotifier {
  OwnerPublishPublicDeals? publicDeals;
  bool isLoading = false;
  List<PublishDeal> publishDeal = [];
  List<PublishDeal> unPublishDeal = [];
  List<PublishDeal> exclusivePublishDeal = [];
  List<PublishDeal> exclusiveUnPublishDeal = [];
  List<Datum> searchDeal = [];

  ValueNotifier<bool> isPublish = ValueNotifier(true);
  ValueNotifier<bool> isExclusivePublish = ValueNotifier(true);
  bool isSearchData = false;

  setPublishValue(bool value) {
    isPublish.value = value;
    notifyListeners();
  }
  setExclusivePublishValue(bool value) {
    isExclusivePublish.value = value;
    notifyListeners();
  }
  setIsSearchData(bool value) {
    isSearchData = value;
    notifyListeners();
  }

  setOwnerPublishPublicDeals( List<PublishDeal> value) {
    for (var element in value) {
      publishDeal.add(element);
    }
    notifyListeners();
  }
  setOwnerUnPublishPublicDeals( List<PublishDeal> value) {
    for (var element in value) {
      unPublishDeal.add(element);
    }
    notifyListeners();
  }
  setOwnerExclusivePublishPublicDeals( List<PublishDeal> value) {
    for (var element in value) {
      exclusivePublishDeal.add(element);
    }
    notifyListeners();
  }
  setOwnerExclusiveUnPublishPublicDeals( List<PublishDeal> value) {
    for (var element in value) {
      exclusiveUnPublishDeal.add(element);
    }
    notifyListeners();
  }
  setSearchDeals( List<Datum> value) {
    for (var element in value) {
      searchDeal.add(element);
    }
    notifyListeners();
  }

  setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
//   ====================== public   deals =======================

  Future<void> publicDealsApi() async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        setIsLoading(true);
        notifyListeners();
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .publishDeal(url: AppNetworkUrls.ownerPublishDeal)
            .then((value) async {
          final publishPublicResponse = OwnerPublishPublicDeals.fromJson(value);
          logD("UILoginHit: $publishPublicResponse");

          if (publishPublicResponse.success == false) {
            logD("error message: ${publishPublicResponse.message}");
            // Navigator.pop(context);
            setIsLoading(false);
            notifyListeners();
            Toasts.getErrorToast(text: publishPublicResponse.message);
          } else {
            // Navigator.pop(context);
            logD("api response: ${publishPublicResponse.message}");
             publishDeal.clear();
            notifyListeners();
            await setOwnerPublishPublicDeals(publishPublicResponse.data!.publishDeal!);
            notifyListeners();
            unPublishDeal.clear();
            notifyListeners();
            await setOwnerUnPublishPublicDeals(publishPublicResponse.data!.unpublishDeal!);
            notifyListeners();
            setIsLoading(false);
            notifyListeners();
            Toasts.getSuccessToast(text: publishPublicResponse.message);
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

//   ====================== exclusive deals =======================
  Future<void> exclusiveDealsApi() async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        setIsLoading(true);
        notifyListeners();
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .publishDeal(url: AppNetworkUrls.ownerExclusivePublishDeal)
            .then((value) async {
          final exclusiveDealsResponse = OwnerPublishPublicDeals.fromJson(value);
          logD("UILoginHit: $exclusiveDealsResponse");
          if (exclusiveDealsResponse.success == false) {
            logD("error message: ${exclusiveDealsResponse.message}");
            // Navigator.pop(context);
            setIsLoading(false);
            notifyListeners();
            Toasts.getErrorToast(text: exclusiveDealsResponse.message);
          } else {
            // Navigator.pop(context);
            logD("api response: ${exclusiveDealsResponse.message}");
            exclusivePublishDeal.clear();
            notifyListeners();
            await setOwnerExclusivePublishPublicDeals(exclusiveDealsResponse.data!.publishDeal!);
            notifyListeners();
            exclusiveUnPublishDeal.clear();
            notifyListeners();
            await setOwnerExclusiveUnPublishPublicDeals(exclusiveDealsResponse.data!.unpublishDeal!);
            notifyListeners();
            setIsLoading(false);
            notifyListeners();
            Toasts.getSuccessToast(text: exclusiveDealsResponse.message);
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

//   ====================== search deals =======================
  Future<void> searchDealsPublish({required isExclusiveDeal,required isPublishDeal,required searchText,required userType}) async {
    await (Connectivity().checkConnectivity()).then((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        // CustomLoader.fetchData(context);
        setIsLoading(true);
        notifyListeners();
        SearchDealRequest data = SearchDealRequest(isExclusiveDeal:isExclusiveDeal ,isPublishDeal:isPublishDeal ,search:searchText ,userType: userType
        );
        // Call Function from the Repository Class
        await AuthRepository.authRepositoryInstance
            .searchDealApi(url: AppNetworkUrls.searchDeals, data:data )
            .then((value) async {
          final searchResponse = SearchDealResponse.fromJson(value);
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
            searchDeal.clear();
            notifyListeners();
            await setSearchDeals(searchResponse.data!);
            notifyListeners();
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
}
