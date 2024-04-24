import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/widgets/favmovies_list.dart';

import 'package:provider/provider.dart';

import '../helpers/app_colors.dart';

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: DefaultTabController(
              initialIndex: selectedIndex,
              length: 2,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: true,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Favorite Movies',
                      style: AppStyles.movieTypeTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Watching List',
                      style: AppStyles.movieTypeTextStyle,
                    ),
                  ),
                ],
                onTap: (value) {
                  selectedIndex = value;
                  setState(() {});
                },
                indicatorColor: AppColors.borderColor,
              ),
            ),
          ),
          MoviesList(
            index: selectedIndex,
            future: selectedIndex == 0
                ? Provider.of<Movies>(context, listen: false).getFavMovies()
                : Provider.of<Movies>(context, listen: false).getListMovies(),
          ),
        ],
      ),
    );
  }
}
