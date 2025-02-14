import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/widgets/app_button.dart';
import 'package:clixx/app/routes/app_routes.dart';
import 'package:clixx/services/navigation_service.dart';

class PasswordResetSuccessView extends StatelessWidget {
  const PasswordResetSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons(
                icon: AppIconData.successmark,
                size: 64.w,
              ),
              AppSpacing.v24(),
              Text(
                'Password Reset Successful',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              AppSpacing.v8(),
              Text(
                'Your password has been reset successfully.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              AppSpacing.v32(),
              AppButton(
                text: 'Back to Login',
                onPressed: () => NavigationService.pushReplacementNamed(
                  AppRoutes.signInView,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 