import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'local_store/shared_preference.dart';
import 'modules/auth/forget_password/provider/forget_password_provider.dart';
import 'modules/auth/logIn/provider/login_provider.dart';
import 'modules/auth/sign_up/email_verification_success/provider/email_verify_provider.dart';
import 'modules/auth/sign_up/otp_screen/provider/otp_provider.dart';
import 'modules/auth/sign_up/sign_up_influencer/sign_up_provider/sign_up_provider.dart';
import 'modules/auth/user_type/provider/user_type_provider.dart';
import 'modules/home/provider/create_provider.dart';
import 'modules/home/provider/deals_provider.dart';
import 'modules/home/provider/home_provider.dart';
import 'modules/home/qr_scanner/provider/qr_provider.dart';
import 'modules/splash/splash_screen.dart';
import 'routes/app_routes.dart';
import 'routes/route_name.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  // await Permission.contacts.request();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => LogInProvider()),
          ChangeNotifierProvider(create: (_) => UserTypeProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => EmailVerifySuccessProvider()),
          ChangeNotifierProvider(create: (_) => OtpProvider()),
          ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
          ChangeNotifierProvider(create: (_) => DealsProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => QrProvider()),
          ChangeNotifierProvider(create: (_) => CreateProvider()),

        ],
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Foodie Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          initialRoute: RouteName.splashScreen,
          onGenerateRoute: AppRoute.generateRoute,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
