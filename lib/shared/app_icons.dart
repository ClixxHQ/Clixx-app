// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconData {
  static const String _basePath = 'assets/svgs/';
  static const String user = '${_basePath}user.svg';
  static const String user1 = '${_basePath}user1.svg';
  static const String calendar = '${_basePath}calendar.svg';
  static const String successmark = '${_basePath}successmark.svg';
  static const String add = '${_basePath}add.svg';
  static const String google = '${_basePath}google.svg';
  static const String apple = '${_basePath}apple.svg';
  static const String activeChat = '${_basePath}active-chat.svg';
  static const String activeDashboard = '${_basePath}active-dashboard.svg';
  static const String activeHome = '${_basePath}active-home.svg';
  static const String activeUserMultiple = '${_basePath}active-user-multiple.svg';
  static const String activemarket = '${_basePath}activemarket.svg';
  static const String airplane = '${_basePath}airplane-01.svg';
  static const String arrowLeft = '${_basePath}arrow-left.svg';
  static const String backpack = '${_basePath}backpack.svg';
  static const String binoculars = '${_basePath}binoculars.svg';
  static const String book = '${_basePath}book.svg';
  static const String bookmarkX = '${_basePath}bookmark-x.svg';
  static const String bookmark = '${_basePath}bookmark.svg';
  static const String briefcase = '${_basePath}briefcase.svg';
  static const String bubbleChatAdd = '${_basePath}bubble-chat-add.svg';
  static const String cart = '${_basePath}cart.svg';
  static const String chair = '${_basePath}chair.svg';
  static const String chat = '${_basePath}chat.svg';
  static const String circleX = '${_basePath}circle-x.svg';
  static const String close = '${_basePath}close.svg';
  static const String copy = '${_basePath}copy.svg';
  static const String dashboard = '${_basePath}dashboard.svg';
  static const String delete = '${_basePath}delete.svg';
  static const String delete1 = '${_basePath}delete1.svg';
  static const String deliveredCheckmark = '${_basePath}delivered-checkmark.svg';
  static const String filePenLine = '${_basePath}file-pen-line.svg';
  static const String filter = '${_basePath}filter.svg';
  static const String fireworks = '${_basePath}fireworks.svg';
  static const String gameController = '${_basePath}game-controller.svg';
  static const String helpSquare = '${_basePath}help-square.svg';
  static const String landmark = '${_basePath}landmark.svg';
  static const String legalDocument = '${_basePath}legal-document.svg';
  static const String library = '${_basePath}library.svg';
  static const String location = '${_basePath}location.svg';
  static const String location1 = '${_basePath}location1.svg';
  static const String logout = '${_basePath}logout.svg';
  static const String love = '${_basePath}love.svg';
  static const String loved = '${_basePath}loved.svg';
  static const String market = '${_basePath}market.svg';
  static const String messageCircle = '${_basePath}message-circle.svg';
  static const String messageSquareWarning = '${_basePath}message-square-warning.svg';
  static const String mic = '${_basePath}mic.svg';
  static const String mic1 = '${_basePath}mic1.svg';
  static const String mic2 = '${_basePath}mic2.svg';
  static const String moreHorizontal = '${_basePath}more-horizontal.svg';
  static const String moreVertical = '${_basePath}more-vertical.svg';
  static const String notepad = '${_basePath}Notepad.svg';
  static const String notification = '${_basePath}notification.svg';
  static const String notification1 = '${_basePath}notification1.svg';
  static const String officeChair = '${_basePath}office-chair.svg';
  static const String office = '${_basePath}office.svg';
  static const String pencilLine = '${_basePath}pencil-line.svg';
  static const String plus = '${_basePath}plus.svg';
  static const String readCheckmark = '${_basePath}read-checkmark.svg';
  static const String repost = '${_basePath}repost.svg';
  static const String resetPassword = '${_basePath}reset-password.svg';
  static const String search = '${_basePath}search.svg';
  static const String sentCheckmark = '${_basePath}sent-checkmark.svg';
  static const String servingFood = '${_basePath}serving-food.svg';
  static const String settings = '${_basePath}settings.svg';
  static const String share = '${_basePath}share.svg';
  static const String share1 = '${_basePath}share1.svg';
  static const String shield = '${_basePath}sheild.svg';
  static const String tech = '${_basePath}tech.svg';
  static const String ticket = '${_basePath}ticket.svg';
  static const String time = '${_basePath}time.svg';
  static const String tools = '${_basePath}tools.svg';
  static const String tv = '${_basePath}tv.svg';
  static const String userMultiple = '${_basePath}user-multiple.svg';
  static const String userSearch = '${_basePath}user-search.svg';
  static const String userX = '${_basePath}user-x.svg';
  static const String users = '${_basePath}users.svg';
  static const String video = '${_basePath}video.svg';
  static const String video2 = '${_basePath}video2.svg';
  static const String volumeOff = '${_basePath}volume-off.svg';
}

class AppIcons extends StatelessWidget {
  final VoidCallback? onPressed;
  final String icon;
  final double size;
  final Color? color;
  const AppIcons({
    super.key,
    this.onPressed,
    this.color,
    required this.icon,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SvgPicture.asset(
        icon,
        height: size,
        width: size,
        color: color,
      ),
    );
  }
} 