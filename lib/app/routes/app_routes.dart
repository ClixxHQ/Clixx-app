import 'package:flutter/material.dart';
import 'package:clixx/ui/views/onboarding/splash_screen_view.dart';
import 'package:clixx/ui/views/onboarding/onboarding_view.dart';
import 'package:clixx/ui/views/authentication/sign_up_view.dart';
import 'package:clixx/ui/views/authentication/otp_verification_view.dart';

class AppRoutes {
  // Base Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signUp = '/sign-up';
  static const String otpVerification = '/otp-verification';

  static const String initialRoute = splash;

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreenView(),
    onboarding: (context) => const OnboardingView(),
    signUp: (context) => const SignUpView(),
    otpVerification: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return OtpVerificationView(
        phoneNumber: args['phoneNumber'],
        email: args['email'],
        firstName: args['firstName'],
        lastName: args['lastName'],
        birthday: args['birthday'],
        referralCode: args['referralCode'],
      );
    },
  };
} 