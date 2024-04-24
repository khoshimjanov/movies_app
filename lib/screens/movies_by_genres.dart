import 'package:flutter/material.dart';
import 'package:movies_app/widgets/genre_item.dart';

import '../helpers/app_colors.dart';

// ignore: must_be_immutable
class MoviesByGenres extends StatefulWidget {
  int selectedIndex;
  MoviesByGenres({super.key, required this.selectedIndex});

  @override
  State<MoviesByGenres> createState() => _MoviesByGenresState();
}

class _MoviesByGenresState extends State<MoviesByGenres> {
  List<Map<String, dynamic>> movieGenres = [
    {'genre': "Action", "id": 28},
    {
      'genre': "Adventure",
      "id": 12,
    },
    {
      'genre': "Animation",
      "id": 16,
    },
    {
      'genre': "Comedy",
      "id": 35,
    },
    {'genre': "Crime", "id": 80},
    {'genre': "Documentary", "id": 99},
    {
      'genre': "Drama",
      "id": 18,
    },
    {
      'genre': "Family",
      "id": 10751,
    },
    {
      'genre': "Fantasy",
      "id": 14,
    },
    {
      'genre': "Horror",
      "id": 27,
    },
    {
      'genre': "Music",
      "id": 10402,
    },
  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainbackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Movie Details', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.mainbackgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 30),
          child: DefaultTabController(
            initialIndex: widget.selectedIndex,
            length: movieGenres.length,
            child: TabBar(
              isScrollable: true,
              tabs: List.generate(
                movieGenres.length,
                (i) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(movieGenres[i]['genre'].toString()),
                ),
              ),
              onTap: (value) {
                widget.selectedIndex = value;
                setState(() {});
              },
              indicatorColor: AppColors.borderColor,
            ),
          ),
        ),
      ),
      body: GenreItem(
        genreId: int.parse(movieGenres[widget.selectedIndex]['id'].toString()),
      ),
    );
  }
}
