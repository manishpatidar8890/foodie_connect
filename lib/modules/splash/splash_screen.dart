import 'dart:async';
import '../../core_utils/export_dependency.dart';
import '../../local_store/shared_preference.dart';
import '../../routes/route_name.dart';
import '../../widgets/map_placeholder.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
if(PreferenceUtils.getAccessToken()=="") {
  Navigator.pushReplacementNamed(context, RouteName.loginScreen);
}else{
   Navigator.pushReplacementNamed(context, RouteName.bottomNavigationBarScreen);
}
// else if(PreferenceUtils.getUserType()!=""&& PreferenceUtils.getUserType().toString()=="Influencer"){
//   Navigator.pushReplacementNamed(context, RouteName.completeInfluencerProfileScreen);
// }else{
//   // Navigator.pushReplacementNamed(context, RouteName.);
//   Navigator.pushReplacementNamed(context, RouteName.completeBusinessProfileScreen);
// }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AppImage.splashImage,
              height: AppDimens.height150,
              width: AppDimens.height150,
            ),
          ),
        ],
      ),
    );
  }
}
