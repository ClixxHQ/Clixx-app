import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clixx/shared/app_colors.dart';
import 'package:clixx/shared/app_icons.dart';
import 'package:clixx/shared/app_images.dart';
import 'package:clixx/ui/widgets/home/app_bottom_nav.dart';
import 'package:clixx/ui/widgets/home/app_drawer.dart';
import 'package:clixx/ui/widgets/home/feed_post_card.dart';
import 'package:clixx/ui/widgets/home/new_post_input.dart';
import 'package:clixx/services/navigation_service.dart';
import 'package:clixx/app/routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onBottomNavTapped(int index) {
    if (index == _currentIndex) return;
    
    setState(() {
      _currentIndex = index;
    });

    // For now, navigate back to HomeView for all tabs
    if (index != 0) {
      NavigationService.pushReplacementNamed(AppRoutes.homeView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: _currentIndex == 0 
            ? Column(
                children: [
                  Container(
                    color: AppColors.background,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                            icon: AppIcons(
                              icon: AppIconData.menu,
                              size: 14.w,
                            ),
                          ),
                          Expanded(
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                tabBarTheme: const TabBarTheme(
                                  labelColor: Colors.black,
                                  unselectedLabelColor: AppColors.grey300,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  dividerColor: Colors.transparent,
                                  indicatorColor: Colors.black,
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                tabs: const [
                                  Tab(text: 'Following'),
                                  Tab(text: 'For You'),
                                ],
                                indicatorWeight: 1,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO: Handle notification
                            },
                            icon: AppIcons(
                              icon: AppIconData.notification,
                              size: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildFeedList(),
                        _buildFeedList(),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _getTitleForIndex(_currentIndex),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey400,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Coming Soon!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  String _getTitleForIndex(int index) {
    switch (index) {
      case 1:
        return 'Market';
      case 2:
        return 'Products';
      case 3:
        return 'Community';
      case 4:
        return 'Chat';
      default:
        return 'Home';
    }
  }

  Widget _buildFeedList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      children: const [
        NewPostInput(),
        FeedPostCard(
          username: 'big_Sammy 💯',
          timeAgo: '2 secs ago',
          content: 'Dear corp members, what\'s something you love about your state of posting?',
          hashtag: '#KadunaCorper',
          avatarImage: AppImageData.image4,
          reactionCount: 5,
          commentCount: 10,
          repostCount: 2,
        ),
        FeedPostCard(
          username: 'beautyqween',
          timeAgo: '1d ago',
          content: 'Moving in the streets of Lagos and meeting exciting new people.',
          hashtag: '#KadunaCorper',
          images: [AppImageData.image5, AppImageData.image6],
          avatarImage: AppImageData.image3,
          reactionCount: 5,
          commentCount: 10,
          repostCount: 2,
        ),
        FeedPostCard(
          username: 'beautyqween',
          timeAgo: '1d ago',
          content: 'Moving in the streets of Lagos and meeting exciting new people.',
          hashtag: '#KadunaCorper',
          images: [AppImageData.image1],
          avatarImage: AppImageData.image2,
          reactionCount: 5,
          commentCount: 10,
          repostCount: 2,
        ),
      ],
    );
  }
} 