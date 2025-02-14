import 'package:flutter/material.dart';
import 'package:clixx/ui/views/onboarding/splash_screen_view.dart';
import 'package:clixx/ui/views/onboarding/onboarding_view.dart';
import 'package:clixx/ui/views/authentication/sign_up_view.dart';
import 'package:clixx/ui/views/authentication/sign_in_view.dart';
import 'package:clixx/ui/views/authentication/otp_verification_view.dart';
import 'package:clixx/ui/views/authentication/verification_success_view.dart';
import 'package:clixx/ui/views/authentication/setup_profile_view.dart';
import 'package:clixx/ui/views/authentication/forgot_password_view.dart';
import 'package:clixx/ui/views/authentication/reset_password_view.dart';
import 'package:clixx/ui/views/authentication/password_reset_success_view.dart';
import 'package:clixx/ui/views/home/home_view.dart';

class AppRoutes {
  // Base Routes
  static const String splashScreenView = '/splashScreenView';
  static const String onboardingView = '/onboardingView';
  static const String signUpView = '/signUpView';
  static const String signInView = '/signInView';
  static const String otpVerificationView = '/otpVerificationView';
  static const String verificationSuccessView = '/verificationSuccessView';
  static const String setupProfileView = '/setupProfileView';
  static const String forgotPasswordView = '/forgotPasswordView';
  static const String resetPasswordView = '/resetPasswordView';
  static const String passwordResetSuccessView = '/passwordResetSuccessView';
  static const String homeView = '/homeView';

  static const String initialRoute = splashScreenView;

  static Map<String, WidgetBuilder> routes = {
    splashScreenView: (context) => const SplashScreenView(),
    onboardingView: (context) => const OnboardingView(),
    signUpView: (context) => const SignUpView(),
    signInView: (context) => const SignInView(),
    otpVerificationView: (context) => const OtpVerificationView(),
    verificationSuccessView: (context) => const VerificationSuccessView(),
    setupProfileView: (context) => const SetupProfileView(),
    forgotPasswordView: (context) => const ForgotPasswordView(),
    resetPasswordView: (context) => const ResetPasswordView(),
    passwordResetSuccessView: (context) => const PasswordResetSuccessView(),
    homeView: (context) => const HomeView(),
  };
} 