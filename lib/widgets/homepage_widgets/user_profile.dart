import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_app/gen/assets.gen.dart';
import 'package:movies_app/helpers/app_colors.dart';

import 'package:provider/provider.dart';

import '../../providers/user.dart';
import 'name_change.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context).person;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome ${user.name}',
              style: const TextStyle(color: AppColors.maindarkTextColor),
            ),
            const Text("Bring popcorn, it's a movie time."),
          ],
        ),
        CupertinoButton(
          onPressed: () => showModalBottomSheet(
            backgroundColor: AppColors.mainbackgroundColor,
            context: context,
            builder: (context) => const NameChange(),
          ),
          child: SvgPicture.asset(
            Assets.icons.ninjaMediumLightSkinToneSvgrepoCom,
          ),
        ),
      ],
    );
  }
}
