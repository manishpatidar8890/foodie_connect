import 'package:foodie_connect/modules/auth/sign_up/email_verification_success/screens/email_verify_success.dart';

import '../modules/auth/forget_password/modal/arg_modal.dart';
import '../modules/auth/forget_password/screens/forget_otp.dart';
import '../modules/auth/forget_password/screens/forget_otp_verify.dart';
import '../modules/auth/forget_password/screens/forget_password_screen.dart';
import '../modules/auth/forget_password/screens/new_password.dart';
import '../modules/auth/sign_up/otp_screen/screens/otp_screen.dart';
import '../modules/auth/sign_up/sign_up_business_owner/screens/complete_business_profile.dart';
import '../modules/auth/sign_up/sign_up_business_owner/screens/sign_up_business_owner.dart';
import '../modules/auth/sign_up/sign_up_influencer/screens/complete_influencer_profile.dart';
import '../modules/auth/sign_up/sign_up_influencer/screens/sign_up_influencer.dart';
import '../modules/auth/user_type/screens/user_type.dart';
import '../modules/home/bottom_navigation_bar.dart';
import '../modules/home/deals/create_deals/create_deals.dart';
import '../modules/home/deals/exclusive_deals/exclusive_deals_information.dart';
import '../modules/home/deals/public_deals/public_deals_information.dart';
import '../modules/home/deals/unpublish_deals/unpublished_deal_information.dart';
import '../modules/home/qr_scanner/screens/qr_details.dart';
import '../modules/home/qr_scanner/screens/qr_screen.dart';
import '../widgets/map_placeholder.dart';
import 'route_name.dart';
import 'routes_export.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RouteName.userTypeScreen:
        return MaterialPageRoute(builder: (context) => const UserTypeScreen());

      case RouteName.signUpInfluencerScreen:
        return MaterialPageRoute(
            builder: (context) => const SignUpInfluencerScreen());

      case RouteName.signUpBusinessOwnerScreen:
        return MaterialPageRoute(
            builder: (context) => const SignUpBusinessOwnerScreen());

      case RouteName.emailVerifySuccessScreen:
        return MaterialPageRoute(
            builder: (context) => const EmailVerifySuccessScreen());
      case RouteName.otpScreen:
        String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => OtpScreen(
                  email: email,
                ));
      case RouteName.forgetPasswordScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordScreen());
      case RouteName.forgetPasswordOtpScreen:
        String email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => ForgetPasswordOtpScreen(email: email));
      case RouteName.forgetPassSuccessScreen:
        return MaterialPageRoute(
            builder: (context) => const ForgetPassSuccessScreen());
      case RouteName.newPasswordScreen:
        NewPasswordArg arg = settings.arguments as NewPasswordArg;
        return MaterialPageRoute(
            builder: (context) =>
                NewPasswordScreen(email: arg.email, otp: arg.otpCode));
      case RouteName.completeInfluencerProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const CompleteInfluencerProfileScreen());
      case RouteName.completeBusinessProfileScreen:
        return MaterialPageRoute(
            builder: (context) => const CompleteBusinessProfileScreen());
      case RouteName.googleMapPlaceholder:
        return MaterialPageRoute(
            builder: (context) => const GoogleMapPlaceholder());
      case RouteName.publicDealsInformation:
        return MaterialPageRoute(
            builder: (context) => const PublicDealsInformation());
      case RouteName.exclusiveDealsInformation:
        return MaterialPageRoute(
            builder: (context) => const ExclusiveDealsInformation());
      case RouteName.bottomNavigationBarScreen:
        return MaterialPageRoute(
            builder: (context) => const BottomNavigationBarScreen());
      case RouteName.unpublishedDealsInformation:
        return MaterialPageRoute(
            builder: (context) => const UnpublishedDealsInformation());
      case RouteName.qRScannerScreen:
        return MaterialPageRoute(builder: (context) => const QRScannerScreen());case RouteName.createDealsScreen:
        return MaterialPageRoute(builder: (context) => const CreateDealsScreen());
      case RouteName.qrDetailScreen:
        return MaterialPageRoute(builder: (context) => const QrDetailScreen());

      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
}
