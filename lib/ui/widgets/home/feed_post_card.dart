import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/ui/widgets/home/post_action_sheet.dart';

class FeedPostCard extends StatefulWidget {
  final String username;
  final String timeAgo;
  final String content;
  final String? hashtag;
  final List<String>? images;
  final String avatarImage;
  final int reactionCount;
  final int commentCount;
  final int repostCount;

  const FeedPostCard({
    Key? key,
    required this.username,
    required this.timeAgo,
    required this.content,
    this.hashtag,
    this.images,
    required this.avatarImage,
    required this.reactionCount,
    required this.commentCount,
    required this.repostCount,
  }) : super(key: key);

  @override
  State<FeedPostCard> createState() => _FeedPostCardState();
}

class _FeedPostCardState extends State<FeedPostCard> {
  bool isLoved = false;

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const PostActionSheet(),
    );
  }

  Widget _buildImages() {
    if (widget.images == null || widget.images!.isEmpty) return const SizedBox();

    if (widget.images!.length == 1) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              widget.images!.first,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    // For two images
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  widget.images![0],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  widget.images![1],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: AssetImage(widget.avatarImage),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Posted ${widget.timeAgo}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showActionSheet(context),
                  icon: Icon(
                    Icons.more_horiz,
                    size: 24.w,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              widget.content,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
          ),
          if (widget.hashtag != null)
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 12.h),
              child: Text(
                widget.hashtag!,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                ),
              ),
            ),
          if (widget.images != null) _buildImages(),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppIcons(
                      icon: AppIconData.emojis,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      '${widget.reactionCount} Reactions',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                const Divider(
                  height: 1,
                  color: AppColors.grey600,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            AppIcons(
                              icon: AppIconData.pencilLine,
                              size: 20.w,
                              color: Colors.black54,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                'Write a comment...',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black54,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isLoved = !isLoved;
                        });
                      },
                      icon: AppIcons(
                        icon: isLoved ? AppIconData.loved : AppIconData.love,
                        size: 24.w,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.commentCount.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        AppIcons(
                          icon: AppIconData.messageCircle,
                          size: 24.w,
                        ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Row(
                      children: [
                        Text(
                          widget.repostCount.toString(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        AppIcons(
                          icon: AppIconData.repost,
                          size: 24.w,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 