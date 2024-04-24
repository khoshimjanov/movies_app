import 'package:flutter/cupertino.dart';

import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/screens/movies_by_genres.dart';
import 'package:movies_app/widgets/homepage_widgets/list_of_movies.dart';
import 'package:movies_app/widgets/homepage_widgets/user_profile.dart';

import 'package:provider/provider.dart';

import '../widgets/homepage_widgets/movie_categories.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {  
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserInfo(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Category',
                      style: AppStyles.movieTypeTextStyle,
                    ),
                  ),
                  CupertinoButton(
                    child: const Text('See All'),
                    onPressed: () => Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) => MoviesByGenres(
                          selectedIndex: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const MovieCategories(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Trending Movie',
                  style: AppStyles.movieTypeTextStyle,
                ),
              ),
              ShowMovies(
                future: Provider.of<Movies>(context, listen: false)
                    .getTrendingMovies(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Upcoming Movies',
                  style: AppStyles.movieTypeTextStyle,
                ),
              ),
              ShowMovies(
                future: Provider.of<Movies>(context, listen: false)
                    .getUpcomingMovies(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
