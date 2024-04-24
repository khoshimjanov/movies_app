import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/widgets/error_message.dart';
import 'package:movies_app/widgets/movie_item.dart';
import 'package:provider/provider.dart';

class GenreItem extends StatelessWidget {
  final int genreId;
  const GenreItem({super.key, required this.genreId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<Movies>(context, listen: false).getGenreMovies(genreId),
      builder: (context, snapshot) {
        final List<GroupMovie>? movies = snapshot.data;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const ErrorMessage();
        } else {
          if (snapshot.hasError) {
            return const ErrorMessage();
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: MediaQuery.of(context).size.height * 0.4,
            ),
            itemBuilder: (context, i) => MovieItem(
              movies[i],
              isDouble: true,
            ),
            itemCount: movies!.length,
          );
        }
      },
    );
  }
}
