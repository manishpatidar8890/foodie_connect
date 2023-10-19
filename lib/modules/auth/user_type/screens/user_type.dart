import 'package:flutter/material.dart';
import 'package:foodie_connect/core_utils/app_image.dart';

import '../../../../core_utils/app_colors.dart';
import '../../../../core_utils/app_dimens.dart';
import '../../../../core_utils/app_style.dart';
import '../../../../core_utils/local_strings.dart';
import '../../../../routes/route_name.dart';
import '../../../../routes/routes_export.dart';
import '../../../../widgets/round_button.dart';
import '../provider/user_type_provider.dart';

class UserTypeScreen extends StatefulWidget {
  const UserTypeScreen({super.key});

  @override
  State<UserTypeScreen> createState() => _UserTypeScreenState();
}

class _UserTypeScreenState extends State<UserTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          LocalStrings.createAnAccount,
          style: AppStyle.loginTitleTextStyle,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<UserTypeProvider>(builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder<bool>(
                    valueListenable: provider.isInfluencer,
                    builder: (context, value, child) {
                      return RoundButton(
                        text: LocalStrings.iAmAnInfluencer,
                        onPressedFunction: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          provider.setInfluencerValue(true);
                          provider.setBusinessOwnerValue(false);
                          Navigator.pushNamed(context, RouteName.signUpInfluencerScreen);
                        },
                        color: Colors.transparent,
                        textColor: value ? Colors.red : AppColors.color000000,
                      );
                    }),
                SizedBox(
                  height: AppDimens.height20,
                ),
                ValueListenableBuilder<bool>(
                    valueListenable: provider.isBusinessOwner,
                    builder: (context, value, child) {
                      return RoundButton(
                        text: LocalStrings.iAmABusinessOwner,
                        onPressedFunction: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          provider.setBusinessOwnerValue(true);
                          provider.setInfluencerValue(false);
                          Navigator.pushNamed(context, RouteName.signUpBusinessOwnerScreen);
                        },
                        color: Colors.transparent,
                        textColor: value ? Colors.red : AppColors.color000000,
                      );
                    }),
                const Spacer(),
                SizedBox(
                  height: AppDimens.height20,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
