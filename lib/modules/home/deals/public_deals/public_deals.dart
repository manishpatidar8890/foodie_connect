import 'package:flutter/foundation.dart';
import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/modules/home/provider/deals_provider.dart';
import 'package:foodie_connect/routes/route_name.dart';
import 'package:foodie_connect/widgets/text_form_field_with_prefix_icon_label.dart';
import 'package:intl/intl.dart';

import '../../../../local_store/shared_preference.dart';
import '../../../../network/models/response/publish/owner_publish_public_deals.dart';
import '../../../../network/models/response/publish/search_response.dart';
import '../../../../routes/routes_export.dart';

class PublicDeals extends StatefulWidget {
  const PublicDeals({super.key});

  @override
  State<PublicDeals> createState() => _PublicDealsState();
}

class _PublicDealsState extends State<PublicDeals> {
  late DealsProvider providerDeals;
  TextEditingController searchController=TextEditingController();
  TextEditingController searchUnPublishController=TextEditingController();
  FocusNode searchFocus=FocusNode();
  FocusNode searchUnPublishFocus=FocusNode();
  @override
  void initState() {
    super.initState();
    providerDeals = Provider.of<DealsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerDeals.publicDealsApi();
    });
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PreferenceUtils.clearPreferences();
          Navigator.pushNamed(context, RouteName.createDealsScreen);
        },
        backgroundColor: Colors.white,
        mini: true,
        child: Icon(
          Icons.add_circle,
          color: Colors.black,
          size: AppDimens.height30,
        ),
      ),
      appBar: AppBar(
        title: Text(
          LocalStrings.publicDeals,
          style: AppStyle.loginTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0, leading: const SizedBox(),
        // iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<DealsProvider>(
          builder:
              (BuildContext context, DealsProvider provider, Widget? child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppDimens.width15),
                child:  provider.isPublish.value ==
                    true? Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppDimens.width5),
                            height: AppDimens.height60,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.color000000)),
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      searchController.clear();
                                      searchUnPublishController.clear();
                                      provider.setPublishValue(true);
                                      provider.setIsSearchData(false);
                                    },
                                    child: Container(
                                      height: AppDimens.height50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: provider.isPublish.value ==
                                                      true
                                                  ? AppColors.color000000
                                                  : Colors.transparent)),
                                      child: Center(
                                        child: Text(
                                          "${LocalStrings.published}(3223)",
                                          style: AppStyle
                                              .appBarTitleTextTextTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: AppDimens.width5,
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                      searchUnPublishController.clear();
                                      searchController.clear();
                                      provider.setPublishValue(false);
                                      provider.setIsSearchData(false);

                                    },
                                    child: Container(
                                      height: AppDimens.height50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: provider.isPublish.value ==
                                                      false
                                                  ? AppColors.color000000
                                                  : Colors.transparent)),
                                      child: Center(
                                        child: Text(
                                          "${LocalStrings.unpublished}(3223)",
                                          style: AppStyle
                                              .appBarTitleTextTextTextStyle,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: AppDimens.height20,
                          ),
                          FormFieldWithPrefixIcon(
                            focusNode: searchFocus,
                            prefixIcon: true,controller: searchController,
                            onChanged: (searchData){
                             print( PreferenceUtils.getAccessToken());
                              if(searchData.toString().length>2){
                                provider.searchDealsPublish(isExclusiveDeal:"0",
                                    isPublishDeal:  provider.isPublish.value == true?"1":"0",
                                    searchText: searchData.toString(),
                                    userType: PreferenceUtils.getUserType()
                                );
                                provider.setIsSearchData(true);

                              }else{
                                provider.setIsSearchData(false);
                              }
                            },
                            image: AppImage.searchIcon,
                            hintText: LocalStrings.searchTabForBusinesses,
                          ),
                          SizedBox(
                            height: AppDimens.height20,
                          ),
                          provider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              :  Container(
                              height: AppDimens.height330,
                              child: ListView.builder(
                                itemCount:provider.isSearchData ==true?provider.searchDeal.length: provider.publishDeal.length,
                                itemBuilder: (context, index) {
                                  return provider.isSearchData == true?searchDeals(data: provider.searchDeal[index], onTap: (){}):deals(data: provider.publishDeal[index], onTap: () {});
                                },
                              )),
                        ],
                      ):
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.width5),
                      height: AppDimens.height60,
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: AppColors.color000000)),
                      child: Row(
                        children: [
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                searchController.clear();
                                searchUnPublishController.clear();
                                provider.setPublishValue(true);
                                provider.setIsSearchData(false);
                              },
                              child: Container(
                                height: AppDimens.height50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: provider.isPublish.value ==
                                            true
                                            ? AppColors.color000000
                                            : Colors.transparent)),
                                child: Center(
                                  child: Text(
                                    "${LocalStrings.published}(3223)",
                                    style: AppStyle
                                        .appBarTitleTextTextTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: AppDimens.width5,
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                searchController.clear();
                                searchUnPublishController.clear();
                                provider.setPublishValue(false);
                                provider.setIsSearchData(false);
                              },
                              child: Container(
                                height: AppDimens.height50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: provider.isPublish.value ==
                                            false
                                            ? AppColors.color000000
                                            : Colors.transparent)),
                                child: Center(
                                  child: Text(
                                    "${LocalStrings.unpublished}(3223)",
                                    style: AppStyle
                                        .appBarTitleTextTextTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    FormFieldWithPrefixIcon(
                      focusNode: searchUnPublishFocus,
                      prefixIcon: true,controller: searchUnPublishController,
                      onChanged: (searchData){
                        print( PreferenceUtils.getAccessToken());
                        if(searchData.toString().length>2){
                          provider.searchDealsPublish(isExclusiveDeal:"0",
                              isPublishDeal:  provider.isPublish.value == true?"1":"0",
                              searchText: searchData.toString(),
                              userType: PreferenceUtils.getUserType()
                          );
                          provider.setIsSearchData(true);

                        }else{
                          provider.setIsSearchData(false);
                        }
                      },
                      image: AppImage.searchIcon,
                      hintText: LocalStrings.searchTabForBusinesses,
                    ),
                    SizedBox(
                      height: AppDimens.height20,
                    ),
                    provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        :  Container(
                        height: AppDimens.height330,
                        child: ListView.builder(
                          itemCount:provider.isSearchData ==true?provider.searchDeal.length: provider.unPublishDeal.length,
                          itemBuilder: (context, index) {
                            return provider.isSearchData == true?searchDeals(data: provider.searchDeal[index], onTap: (){}):deals(data: provider.unPublishDeal[index], onTap: () {});
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget deals({required PublishDeal data, required Function() onTap}) {
    String startFormatDate = DateFormat('MMMd'). format(data.startDate!);
    String endFormatDate = DateFormat('d'). format(data.endDate!);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.height20),
        height: AppDimens.height350,
        width: AppDimens.width380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius15),
        ),
        child: Column(
          children: [
            Container(
              height: AppDimens.height180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.image!), fit: BoxFit.fill)),
            ),
            Container(
              height: AppDimens.height160,
              color: AppColors.colorEEEEEE,
              padding: EdgeInsets.all(AppDimens.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "",
                    style: AppStyle.dealTitleStyle,
                  ),
                  Text(
                    "${startFormatDate}-${endFormatDate}" ?? "",
                    style: AppStyle.welcomeToTheFoodiesConnectStyle,
                  ),
                  SizedBox(
                    height: AppDimens.height5,
                  ),
                  Text(LocalStrings.offer,
                    style: AppStyle.forgetPassword,
                  ),
                  SizedBox(
                    height: AppDimens.height5,
                  ),
                   Expanded(
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Flexible(child: Text(LocalStrings.dealDescription,style: AppStyle.welcomeToTheFoodiesConnectStyle,)),
                        Flexible(child: Text(data.description!,style: AppStyle.forgetPassword,)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget searchDeals({required Datum data, required Function() onTap}) {
    String startFormatDate = DateFormat('MMMd'). format(data.startDate!);
    String endFormatDate = DateFormat('d'). format(data.endDate!);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimens.height20),
        height: AppDimens.height350,
        width: AppDimens.width380,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.radius15),
        ),
        child: Column(
          children: [
            Container(
              height: AppDimens.height180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data.image!), fit: BoxFit.fill)),
            ),
            Container(
              height: AppDimens.height160,
              color: AppColors.colorEEEEEE,
              padding: EdgeInsets.all(AppDimens.height10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title ?? "",
                    style: AppStyle.dealTitleStyle,
                  ),
                  Text(
                    "${startFormatDate}-${endFormatDate}" ?? "",
                    style: AppStyle.welcomeToTheFoodiesConnectStyle,
                  ),
                  SizedBox(
                    height: AppDimens.height5,
                  ),
                  Text(LocalStrings.offer,
                    style: AppStyle.forgetPassword,
                  ),
                  SizedBox(
                    height: AppDimens.height5,
                  ),
                  Expanded(
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text(LocalStrings.dealDescription,style: AppStyle.welcomeToTheFoodiesConnectStyle,)),
                        Flexible(child: Text(data.description!,style: AppStyle.forgetPassword,)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
