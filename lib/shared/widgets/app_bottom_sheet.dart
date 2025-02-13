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
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            height: height ?? MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (showDragIndicator) ...[
                  SizedBox(height: 16.h),
                  Container(
                    width: 64.w,
                    height: 5.47.h,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(109.41.r),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragUpdate: (details) {
                      if (enableDrag) {
                        Navigator.of(context).pop();
                      }
                    },
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