import 'package:flutter/material.dart';
import 'package:movies_app/screens/watchlist_page.dart';

import '../screens/category_page.dart';
import '../widgets/navigation_bar.dart';
import '../helpers/app_colors.dart';
import 'homepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _controller = PageController();

  int _selectedIndex = 0;
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackgroundColor,
      bottomNavigationBar: MainNavigationBar(
        action: (index) {
          _controller.jumpToPage(
            index,
          );
          _selectedIndex = index;
          setState(() {});
        },
        selectedIndex: _selectedIndex,
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: (value) {
          _controller.animateToPage(
            value,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
          _selectedIndex = value;
          setState(() {});
        },
        physics: const NeverScrollableScrollPhysics(),
        children:const[HomePage(), CategoryPage(), WatchListPage()],
      ),
    );
  }
}
