import 'package:flutter/material.dart';
import 'package:clixx/ui/views/onboarding/splash_screen_view.dart';
import 'package:clixx/ui/views/onboarding/onboarding_view.dart';
import 'package:clixx/ui/views/authentication/sign_up_view.dart';
import 'package:clixx/ui/views/authentication/otp_verification_view.dart';
import 'package:clixx/ui/views/authentication/verification_success_view.dart';

class AppRoutes {
  // Base Routes
  static const String splashScreenView = '/splashScreenView';
  static const String onboardingView = '/onboardingView';
  static const String signUpView = '/signUpView';
  static const String otpVerificationView = '/otpVerificationView';
  static const String verificationSuccessView = '/verificationSuccessView';

  static const String initialRoute = splashScreenView;

  static Map<String, WidgetBuilder> routes = {
    splashScreenView: (context) => const SplashScreenView(),
    onboardingView: (context) => const OnboardingView(),
    signUpView: (context) => const SignUpView(),
    otpVerificationView: (context) => const OtpVerificationView(),
    verificationSuccessView: (context) => const VerificationSuccessView(),
  };
} 