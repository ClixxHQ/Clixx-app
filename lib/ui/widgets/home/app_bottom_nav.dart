import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_icons.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.grey200,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70.h,
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppColors.primitiveBlue900,
            unselectedItemColor: Colors.black,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 0,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
            ),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.home,
                    size: 24.w,
                    color: currentIndex == 0 ? AppColors.primitiveBlue900 : Colors.black,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.activeHome,
                    size: 24.w,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.market,
                    size: 24.w,
                    color: currentIndex == 1 ? AppColors.primitiveBlue900 : Colors.black,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.activemarket,
                    size: 24.w,
                  ),
                ),
                label: 'Market',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.dashboard,
                    size: 24.w,
                    color: currentIndex == 2 ? AppColors.primitiveBlue900 : Colors.black,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.activeDashboard,
                    size: 24.w,
                  ),
                ),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.userMultiple,
                    size: 24.w,
                    color: currentIndex == 3 ? AppColors.primitiveBlue900 : Colors.black,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.activeUserMultiple,
                    size: 24.w,
                  ),
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.chat,
                    size: 24.w,
                    color: currentIndex == 4 ? AppColors.primitiveBlue900 : Colors.black,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: AppIcons(
                    icon: AppIconData.activeChat,
                    size: 24.w,
                  ),
                ),
                label: 'Chat',
              ),
            ],
          ),
        ),
      ),
    );
  }
} 