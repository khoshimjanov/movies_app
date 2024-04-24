import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/providers/user.dart';
import 'package:movies_app/screens/mainPage.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Scaffold(
                  backgroundColor: AppColors.mainbackgroundColor,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const MainPage(),
      future:Future.wait([
        Provider.of<Movies>(context, listen: false).getFavListMovies(),
        Provider.of<User>(context, listen: false).getUserData()
      ,]) ,
    );
  }
}
