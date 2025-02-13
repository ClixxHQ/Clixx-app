import 'package:flutter/material.dart';
import 'package:clixx/ui/views/onboarding/splash_screen_view.dart';
import 'package:clixx/ui/views/onboarding/onboarding_view.dart';
import 'package:clixx/ui/views/authentication/sign_up_view.dart';
import 'package:clixx/app/routes/app_routes.dart';
import 'package:clixx/app/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clixx',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreenView(),
        AppRoutes.onboarding: (context) => const OnboardingView(),
        AppRoutes.signUp: (context) => const SignUpView(),
      },
    );
  }
}
