import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/gen/assets.gen.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/screens/trailer.dart';
import 'package:provider/provider.dart';

class MovieButtons extends StatelessWidget {
  const MovieButtons({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MovieTrailer(),
              ),
            ),
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.icons.videoSquare,
                  ),
                  const Text(
                    'Watch Trailer',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () => Provider.of<Movies>(context, listen: false)
              .addWatchList(movie.id),
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  Assets.icons.category,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    Provider.of<Movies>(context).watchList.contains(movie.id)
                        ? "Remove From My\nWatching List"
                        : 'Add To My Watching \n List',
                    overflow: TextOverflow.ellipsis,
                    textWidthBasis: TextWidthBasis.parent,
                    // style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
