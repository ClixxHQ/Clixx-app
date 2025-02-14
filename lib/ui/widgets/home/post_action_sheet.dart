import 'package:clixx/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_icons.dart';

class PostActionSheet extends StatelessWidget {
  const PostActionSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.r),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Indicator
              Container(
                width: 64.w,
                height: 5.47.h,
                margin: EdgeInsets.only(top: 16.h, bottom: 26.h),
                decoration: BoxDecoration(
                  color: AppColors.primitiveGrey600,
                  borderRadius: BorderRadius.circular(109.41.r),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Follow Button Section
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            _buildActionItem(
                              icon: AppIconData.userMultiple,
                              title: 'Follow @beautyqueen',
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Bookmark Section
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            _buildActionItem(
                              icon: AppIconData.bookmark,
                              title: 'Bookmark',
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Post Actions (Not Interested, Mute, Block, Report)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            _buildActionItem(
                              icon: AppIconData.circleX,
                              title: 'Not interested in this post',
                              onTap: () => Navigator.pop(context),
                            ),
                            _buildActionItem(
                              icon: AppIconData.volumeOff,
                              title: 'Mute',
                              onTap: () => Navigator.pop(context),
                            ),
                            _buildActionItem(
                              icon: AppIconData.userX,
                              title: 'Block this user',
                              onTap: () => Navigator.pop(context),
                              isDestructive: true,
                            ),
                            _buildActionItem(
                              icon: AppIconData.messageSquareWarning,
                              title: 'Report this post',
                              onTap: () => Navigator.pop(context),
                              isDestructive: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Share Section with Bottom Margin
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            _buildActionItem(
                              icon: AppIconData.share,
                              title: 'Share',
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ),

                      // Bottom Margin for Extra Spacing
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Action Item Builder
  Widget _buildActionItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: AppIcons(
            icon: icon,
            size: 24.w,
            color: isDestructive ? Colors.red : Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: isDestructive ? Colors.red : Colors.black,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}