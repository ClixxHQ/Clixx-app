import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final double radius;
  final double height;
  final double elevation;
  final Widget? suffix;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool enabled;
  final bool loading;
  final TextAlign textAlign;
  final EdgeInsets? margin;

  const AppButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.radius = 14,
    this.height = 52,
    this.elevation = 0,
    this.suffix,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.enabled = true,
    this.loading = false,
    this.textAlign = TextAlign.center,
    this.margin,
  }) : super(key: key);

  factory AppButton.icon({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    double radius = 14,
    double height = 52,
    double elevation = 0,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    bool enabled = true,
    bool loading = false,
    EdgeInsets? margin,
  }) {
    return AppButton(
      text: text,
      onPressed: onPressed,
      radius: radius,
      height: height,
      elevation: elevation,
      backgroundColor: backgroundColor,
      textColor: textColor,
      textStyle: textStyle,
      enabled: enabled,
      loading: loading,
      margin: margin,
      suffix: Icon(
        icon,
        color: textColor ?? Colors.white,
        size: 20.w,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: height.h,
      child: ElevatedButton(
        onPressed: enabled && !loading ? onPressed : null,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: backgroundColor ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
        child: loading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: textColor ?? Colors.white,
                          ),
                      textAlign: textAlign,
                    ),
                  ),
                  if (suffix != null) ...[
                    SizedBox(width: 8.w),
                    suffix!,
                  ],
                ],
              ),
      ),
    );
  }
} 