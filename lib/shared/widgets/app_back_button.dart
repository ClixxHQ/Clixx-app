import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final bool isBorder;
  final bool isBackground;
  const AppBackButton({
    super.key,
    this.isBorder = true,
    this.isBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: isBorder || isBackground
          ? Container(
              height: 41.h,
              width: 41.h,
              margin: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                color: isBackground
                    ? AppColors.grey800.withOpacity(0.8)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isBackground ? Colors.transparent : AppColors.grey200,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 16.w,
                color: isBackground ? Colors.white : Colors.black,
              ),
            )
          : Icon(
              Icons.arrow_back_ios_new,
              size: 20.w,
              color: Colors.black,
            ),
    );
  }
} 