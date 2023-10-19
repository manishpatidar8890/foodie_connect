import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodie_connect/core_utils/export_dependency.dart';
import 'package:foodie_connect/routes/route_name.dart';
import 'package:foodie_connect/routes/routes_export.dart';
import 'package:foodie_connect/widgets/round_button.dart';

import '../../provider/home_provider.dart';
import '../provider/qr_provider.dart';

class QrDetailScreen extends StatefulWidget {
  const QrDetailScreen({super.key});

  @override
  State<QrDetailScreen> createState() => _QrDetailScreenState();
}

class _QrDetailScreenState extends State<QrDetailScreen> {
  bool isAndroid=true;
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      isAndroid=true;
    } else if (Platform.isIOS) {
      isAndroid=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.qRCode,
          style: AppStyle.loginTitleTextStyle,
        ),
        leading: Consumer<HomeProvider>(
          builder: (BuildContext context,homeProvider, Widget? child) {
            return InkWell(onTap: (){
              homeProvider.setPageIndex(2);
              Navigator.pushReplacementNamed(context, RouteName.bottomNavigationBarScreen);
            },child: Icon(isAndroid?Icons.arrow_back:Icons.arrow_back_ios));
          },

        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<QrProvider>(
        builder: (BuildContext context,  provider, Widget? child) {
         return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppDimens.width15),
              child: Column(
                children: [
                  Container(
                    height: AppDimens.height180,
                    width: AppDimens.width380,
                    decoration: BoxDecoration(
                        color: AppColors.colorEEEEEE,
                        borderRadius: BorderRadius.circular(AppDimens.radius20)),
                    child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(provider.scanCount.toString(),style: AppStyle.style28,),
                          Text(LocalStrings.totalScanned,style:AppStyle.signUPTextTextStyle ,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: AppDimens.height20,),
                  Container(
                    height: AppDimens.height180,
                    width: AppDimens.width380,
                    decoration: BoxDecoration(
                        color: AppColors.colorEEEEEE,
                        borderRadius: BorderRadius.circular(AppDimens.radius20)),
                    child: Center(
                      child: Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("3,333",style: AppStyle.style28,),
                          Text(LocalStrings.totalEarnedPoints,style:AppStyle.signUPTextTextStyle ,)
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  RoundButton(color: Colors.transparent, textColor: AppColors.color000000, text:LocalStrings.doneButtonText, onPressedFunction: (){})
                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
