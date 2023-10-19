import 'package:foodie_connect/core_utils/app_colors.dart';
import 'package:foodie_connect/modules/auth/forget_password/provider/forget_password_provider.dart';
import 'package:foodie_connect/widgets/round_button.dart';
import '../../../../../core_utils/app_dimens.dart';
import '../../../../../core_utils/app_image.dart';
import '../../../../../core_utils/app_style.dart';
import '../../../../../core_utils/local_strings.dart';
import '../../../../../routes/routes_export.dart';
import '../../../../routes/route_name.dart';

class ForgetPassSuccessScreen extends StatefulWidget {
  const ForgetPassSuccessScreen({
    super.key,
  });

  @override
  State<ForgetPassSuccessScreen> createState() =>
      _ForgetPassSuccessScreenState();
}

class _ForgetPassSuccessScreenState extends State<ForgetPassSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        bottom: false,
        child: Consumer<ForgetPasswordProvider>(
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
                  LocalStrings.passwordSetSuccessful,
                  style: AppStyle.loginTitleTextStyle,
                ),
                const Spacer(),
                RoundButton(
                    color: Colors.transparent,
                    textColor: AppColors.color000000,
                    text: LocalStrings.doneButtonText,
                    onPressedFunction: () {
                      Navigator.pushReplacementNamed(
                          context, RouteName.loginScreen);
                    })
              ],
            ),
          );
        }),
      ),
    );
  }
}
