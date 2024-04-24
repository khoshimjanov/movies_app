// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:movies_app/gen/assets.gen.dart';
import '../helpers/app_colors.dart';

class MainNavigationBar extends StatelessWidget {
  final Function(int index) action;
  final int selectedIndex;
  const MainNavigationBar({
    super.key,
    required this.action,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.mainbackgroundColor,
      items: [
        BottomNavigationBarItem(
          tooltip: 'Home',
          label: 'Home',
          activeIcon: SvgPicture.asset(
            Assets.icons.home,
            color: AppColors.borderColor,
          ),
          icon: SvgPicture.asset(Assets.icons.home),
        ),
        BottomNavigationBarItem(
          tooltip: 'Explore',
          label: 'Explore',
          activeIcon: SvgPicture.asset(
            Assets.icons.category,
            color: AppColors.borderColor,
          ),
          icon: SvgPicture.asset(
            Assets.icons.category2,
            color: Colors.white38,
          ),
        ),
        BottomNavigationBarItem(
          tooltip: 'Saved',
          label: 'Saved',
          activeIcon: SvgPicture.asset(
            Assets.icons.saved,
            color: AppColors.borderColor,
          ),
          icon: SvgPicture.asset(Assets.icons.saved),
        ),
      ],
      unselectedItemColor: Colors.transparent,
      currentIndex: selectedIndex,
      onTap: action,
    );
  }
}
