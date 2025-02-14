import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_icons.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // First container - Communities to Loans
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      _buildDrawerItem(
                        icon: AppIconData.userMultiple,
                        title: 'Communities',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.library,
                        title: 'Courses',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.briefcase,
                        title: 'Jobs',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.bookmark,
                        title: 'Bookmarks',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.landmark,
                        title: 'Loans',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                // Second container - My Orders and Cart
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      _buildDrawerItem(
                        icon: AppIconData.orders,
                        title: 'My Orders',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.cart,
                        title: 'Cart',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                // Third container - Settings and Feedback
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      _buildDrawerItem(
                        icon: AppIconData.settings,
                        title: 'Settings',
                        onTap: () {},
                      ),
                      _buildDrawerItem(
                        icon: AppIconData.filePenLine,
                        title: 'Feedback',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      leading: AppIcons(
        icon: icon,
        size: 20.w,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }
} 