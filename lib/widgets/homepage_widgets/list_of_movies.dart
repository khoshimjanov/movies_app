import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/error_message.dart';
import 'package:movies_app/widgets/loading.dart';

import '../movie_item.dart';

class ShowMovies extends StatelessWidget {
  final Future<List<GroupMovie>> future;
  const ShowMovies({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorMessage();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          } else {
            return MoviesView(
              movies: snapshot.data!,
            );
          }
        },
      ),
    );
  }
}

class MoviesView extends StatelessWidget {
  final List<GroupMovie> movies;
  const MoviesView({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(
        movies.length,
        (index) => MovieItem(movies[index]),
      ),
    );
  }
}
