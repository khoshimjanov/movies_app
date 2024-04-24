import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/actor.dart';
import 'package:movies_app/screens/cast_detail.dart';

import '../../helpers/app_styles.dart';
import '../error_message.dart';

class CastItem extends StatelessWidget {
  final GroupActor actor;
  const CastItem({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: SizedBox(
              height: 50,
              width: 50,
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CastDetail(groupActor: actor),
                  ),
                ),
                child:
                CachedNetworkImage(
                      imageUrl:
                         'https://image.tmdb.org/t/p/original${actor.profilePath}',
                      errorWidget: (context, url, error) =>
                          const ErrorMessage(),
                      fit: BoxFit.cover,
                    ),
            
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            width: 120,
            alignment: Alignment.center,
            child: Text(
              actor.originalName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            actor.character,
            style: AppStyles.greyTextStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
