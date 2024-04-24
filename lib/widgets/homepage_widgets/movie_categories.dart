import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/helpers/app_styles.dart';

import '../../gen/assets.gen.dart';
import '../../screens/movies_by_genres.dart';

class MovieCategories extends StatelessWidget {
  const MovieCategories({
    super.key,
  });
  static List<String> movieGenreTitles = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Horror",
    "Music",
  ];
  static List<String> movieGenres = [
    Assets.icons.fireSvgrepoCom,
    Assets.icons.ninjaMediumLightSkinToneSvgrepoCom,
    Assets.icons.unicornSvgrepoCom,
    Assets.icons.rollingOnTheFloorLaughingSvgrepoCom,
    Assets.icons.skullSvgrepoCom,
    Assets.icons.cameraSvgrepoCom,
    Assets.icons.dramaEntertainmentTheaterSvgrepoCom,
    Assets.icons.familyWomanWomanGirlBoySvgrepoCom,
    Assets.icons.magicWandWizardSvgrepoCom,
    Assets.icons.faceScreamingInFearSvgrepoCom,
    Assets.icons.musicSvgrepoCom,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          movieGenres.length,
          (index) => Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => MoviesByGenres(
                    selectedIndex: index,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white12,
                    ),
                    child: SvgPicture.asset(
                      movieGenres[index],
                      width: 50,
                    ),
                  ),
                  Text(
                    movieGenreTitles[index],
                    style: AppStyles.greyTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
