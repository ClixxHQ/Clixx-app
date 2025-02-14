import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_spacing.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/widgets/app_button.dart';

class SetupProfileView extends StatelessWidget {
  const SetupProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpacing.v32(),
              Text(
                'Setup your Profile',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.v8(),
              Text(
                'Tell us about yourself to get started.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              AppSpacing.v48(),
              Stack(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primitiveBlue400,
                        width: 2.w,
                      ),
                    ),
                    child: Center(
                      child: AppIcons(
                        icon: AppIconData.user,
                        size: 38.w,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: AppIcons(
                      icon: AppIconData.add,
                      size: 28.w,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppButton(
                text: 'Continue',
                onPressed: () {
                  // TODO: Handle continue
                },
                backgroundColor: AppColors.primitiveBlue50,
                textColor: Colors.white,
              ),
              AppSpacing.v32(),
            ],
          ),
        ),
      ),
    );
  }
} 