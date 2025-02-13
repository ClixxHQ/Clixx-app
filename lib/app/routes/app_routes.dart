import 'package:flutter/material.dart';
import 'package:clixx/ui/views/onboarding/splash_screen_view.dart';
import 'package:clixx/ui/views/onboarding/onboarding_view.dart';
import 'package:clixx/ui/views/authentication/sign_up_view.dart';

class AppRoutes {
  // Base Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signUp = '/sign-up';

  static const String initialRoute = splash;

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreenView(),
    onboarding: (context) => const OnboardingView(),
    signUp: (context) => const SignUpView(),
  };
} 