import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/gen/assets.gen.dart';
import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/screens/movie_detail.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieItem extends StatelessWidget {
  final bool isDouble;
  final GroupMovie movie;
  const MovieItem(this.movie, {this.isDouble = false});

  @override
  Widget build(BuildContext context) {
    final sizeH = MediaQuery.of(context).size.height;
    final sizeW = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  height: sizeH * (isDouble ? 0.3 : 0.25),
                  width: sizeW * (isDouble ? 0.5 : 0.35),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MovieDetail(id: movie.id),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original${movie.posterPath}',
                      errorWidget: (context, url, error) =>
                          Image.asset(Assets.icons.placeholder.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    Provider.of<Movies>(
                      context,
                      listen: false,
                    ).addFavourite(movie.id);
                  },
                  child: SvgPicture.asset(
                    Provider.of<Movies>(context)
                            .favouriteMovies
                            .contains(movie.id)
                        ? Assets.icons.heartFill
                        : Assets.icons.heartOutline,
                    fit: BoxFit.cover,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            width: 120,
            alignment: Alignment.center,
            child: Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${movie.voteAverage} ",
            style: AppStyles.greyTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
