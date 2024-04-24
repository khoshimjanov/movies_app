import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/error_message.dart';
import 'package:movies_app/widgets/favmovie_item.dart';
import 'package:movies_app/widgets/loading.dart';

import '../helpers/app_styles.dart';

class MoviesList extends StatelessWidget {
  final Future<List<Movie>> future;

  final int index;
  const MoviesList({
    super.key,
    required this.future,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        final List<Movie>? movies=snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }

        if (snapshot.hasError) {
          return const ErrorMessage();
        }
        return MoviesView(movies: movies!);
      },
    );
  }
}

class MoviesView extends StatelessWidget {
  const MoviesView({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const Center(
        child: Text(
          'No movies found!',
          style: AppStyles.movieTypeTextStyle,
        ),
      );
    }
    return Column(
      children: List.generate(
        movies.length,
        (index) => FavMovieItem(movie: movies[index]),
      ),
    );
  }
}
