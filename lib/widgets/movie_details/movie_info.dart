import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/gen/assets.gen.dart';

import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/models/movie.dart';

class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.icons.videoPlay,
                ),
                const Text('Genre'),
                Column(
                  children: List.generate(
                    movie.genres.length,
                    (i) => Text(
                      movie.genres[i].name,
                      style: AppStyles.greyTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.icons.clock,
                ),
                const Text(
                  'Duration',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  "${movie.runTime} mins",
                  style: AppStyles.greyTextStyle,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                SvgPicture.asset(
                  Assets.icons.star,
                ),
                const Text('Rating'),
                Text(
                  movie.voteAverage.toString(),
                  style: AppStyles.greyTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
