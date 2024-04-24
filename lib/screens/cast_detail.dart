
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/widgets/error_message.dart';
import 'package:movies_app/widgets/loading.dart';
import 'package:provider/provider.dart';

import '../gen/assets.gen.dart';
import '../helpers/app_colors.dart';
import '../providers/movies.dart';

class CastDetail extends StatelessWidget {
  final GroupActor groupActor;
  const CastDetail({super.key, required this.groupActor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Actor Details', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.mainbackgroundColor,
      ),
      backgroundColor: AppColors.mainbackgroundColor,
      body: FutureBuilder(
        future:
            Provider.of<Movies>(context, listen: false).getActor(groupActor.id),
        builder: (context, snapshot) {
          final Actor? actor = snapshot.data;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original${actor!.profilePath}',
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            Assets.icons.placeholder.path,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      actor.name,
                      style: AppStyles.movieTypeTextStyle,
                    ),
                    Text(actor.biography)
                  ],
                ),
              ),
            );
          }
          return const ErrorMessage();
        },
      ),
    );
  }
}
