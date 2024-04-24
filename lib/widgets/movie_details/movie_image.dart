import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/gen/assets.gen.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:provider/provider.dart';

class MovieImage extends StatelessWidget {
  const MovieImage({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            "https://image.tmdb.org/t/p/original${movie.posterPath}",
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CupertinoButton(
            onPressed: () {
              Provider.of<Movies>(
                context,
                listen: false,
              ).addFavourite(movie.id);
            },
            child: SvgPicture.asset(
              Provider.of<Movies>(context).favouriteMovies.contains(movie.id)
                  ? Assets.icons.heartFill
                  : Assets.icons.heartOutline,
              width: 40,
            ),
          ),
        )
      ],
    );
  }
}
