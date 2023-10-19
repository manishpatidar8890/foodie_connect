import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/widgets/round_button.dart';

import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_image.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../local_store/shared_preference.dart';
import '../../../../../routes/route_name.dart';
import '../../../../../routes/routes_export.dart';
import '../provider/email_verify_provider.dart';

class EmailVerifySuccessScreen extends StatefulWidget {
  const EmailVerifySuccessScreen({
    super.key,
  });

  @override
  State<EmailVerifySuccessScreen> createState() =>
      _EmailVerifySuccessScreenState();
}

class _EmailVerifySuccessScreenState extends State<EmailVerifySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<EmailVerifySuccessProvider>(
            builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimens.width15, vertical: AppDimens.height15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: AppDimens.height120,
                  margin: EdgeInsets.symmetric(horizontal: AppDimens.width20),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimens.width20,
                      vertical: AppDimens.height20),
                  child: Center(
                    child: Image.asset(
                      AppImage.verified,
                    ),
                  ),
                ),
                Text(
                  LocalStrings.accountVerificationSuccessful,
                  style: AppStyle.loginTitleTextStyle,
                ),
                const Spacer(),
                RoundButton(
                    color: Colors.transparent,
                    textColor: AppColors.color000000,
                    text: LocalStrings.next,
                    onPressedFunction: () {
                      if(PreferenceUtils.getUserType()=="Influencer"){
                        Navigator.pushReplacementNamed(context, RouteName.completeInfluencerProfileScreen);
                      }else{
                        Navigator.pushReplacementNamed(context, RouteName.completeBusinessProfileScreen);
                      }
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
