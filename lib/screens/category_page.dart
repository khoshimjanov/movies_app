import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/helpers/app_styles.dart';
import 'package:movies_app/widgets/error_message.dart';
import 'package:movies_app/widgets/movie_item.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../providers/movies.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor, width: 0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        decoration: const InputDecoration(
                          hintText: 'enter a name of a movie',
                          hintStyle: AppStyles.greyTextStyle,
                          border: InputBorder.none,
                        ),
                        style: AppStyles.movieTypeTextStyle,
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: const Icon(Icons.search),
                    onPressed: () => setState(() {}),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: controller.text.isEmpty
                  ? Provider.of<Movies>(context, listen: false)
                      .getUpcomingMovies()
                  : Provider.of<Movies>(context, listen: false)
                      .searchMovies(controller.text),
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
                  if (movies!.isEmpty) {
                    return const Center(
                      child: Text(
                        'No movies found!',
                        style: AppStyles.movieTypeTextStyle,
                      ),
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent:
                            MediaQuery.of(context).size.height * 0.4,
                      ),
                      itemBuilder: (context, i) => MovieItem(
                        movies[i],
                        isDouble: true,
                      ),
                      itemCount: movies.length,
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
