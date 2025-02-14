import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/widgets/app_button.dart';

class VerificationSuccessView extends StatelessWidget {
  const VerificationSuccessView({Key? key}) : super(key: key);

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
                'Verification Successful',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              AppSpacing.v8(),
              Text(
                'Your phone number is now verified.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              AppSpacing.v32(),
              AppButton(
                text: 'Setup your profile',
                onPressed: () {
                  // TODO: Navigate to profile setup
                },
              ),
              AppSpacing.v16(),
              TextButton(
                onPressed: () {
                  // TODO: Skip profile setup
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 