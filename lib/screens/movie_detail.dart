import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/widgets/movie_details/cast_item.dart';
import 'package:provider/provider.dart';

import '../widgets/error_message.dart';
import '../widgets/loading.dart';
import '../widgets/movie_details/movie_buttons.dart';
import '../widgets/movie_details/movie_image.dart';
import '../widgets/movie_details/movie_info.dart';
import '../widgets/movie_item.dart';

class MovieDetail extends StatelessWidget {
  final int id;
  const MovieDetail({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackgroundColor,
      appBar: const CupertinoNavigationBar(
        middle: Text('Movie Details', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.mainbackgroundColor,
      ),
      body: FutureBuilder(
        future: Provider.of<Movies>(context, listen: false).getMovie(id),
        builder: (context, AsyncSnapshot<Movie> snapshot) {
          if (snapshot.hasError) const ErrorMessage();
          if (snapshot.hasData) {
            final movie = snapshot.data;
            return MovieDetailsView(movie: movie!);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          return const ErrorMessage();
        },
      ),
    );
  }
}

class MovieDetailsView extends StatelessWidget {
  final Movie movie;
  const MovieDetailsView({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: MovieImage(movie: movie),
                ),
                Expanded(
                  flex: 2,
                  child: MovieInfo(movie: movie),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                movie.title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            MovieButtons(movie: movie),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                'Plot Summary',
                style: AppStyles.greyTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                movie.overview,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Cast',
                style: AppStyles.greyTextStyle,
              ),
            ),
            Cast(movie: movie),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Similar Movies',
                style: AppStyles.greyTextStyle,
              ),
            ),
            RecommendedMovies(movie: movie),
          ],
        ),
      ),
    );
  }
}

class Cast extends StatelessWidget {
  const Cast({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Movies>(context, listen: false).getCast(movie.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) const ErrorMessage();
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Loading();
        }

        if (snapshot.hasData) {
          final List<GroupActor>? cast = snapshot.data;
          return SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                cast!.length,
                (i) => CastItem(actor: cast[i]),
              ),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}

class RecommendedMovies extends StatelessWidget {
  const RecommendedMovies({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder(
        future: Provider.of<Movies>(context, listen: false)
            .getRecommendedMovies(movie.id),
        builder: (context, snapshot) {
          final cast = snapshot.data;
          if (snapshot.hasError) const ErrorMessage();
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                cast!.length,
                (index) => MovieItem(cast[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
