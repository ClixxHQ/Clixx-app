import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/services/navigation_service.dart';

class AppBottomSheet {
  static void showBottomSheet({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showDragIndicator = false,
    Color? backgroundColor,
    double? height,
    bool isScrollControlled = false,
  }) {
    final context = NavigationService.navigatorKey.currentContext;

    if (context != null) {
      showModalBottomSheet(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        constraints: height != null
            ? BoxConstraints(
                maxHeight: height,
                minHeight: height,
              )
            : null,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragIndicator) ...[
                  SizedBox(height: 8.h),
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: child,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
} 