import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/helpers/app_colors.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/providers/movies.dart';
import 'package:movies_app/screens/movie_detail.dart';
import 'package:provider/provider.dart';

class FavMovieItem extends StatelessWidget {
  final Movie movie;
  const FavMovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetail(id:  movie.id),
      ),),
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding:const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${movie.posterPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:  5),
                child: Column(
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(color: AppColors.borderColor),
                    ),
                    Text(
                      movie.overview,
                      maxLines: 3, 
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: CupertinoButton(
                  child:const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: (){
                    Provider.of<Movies>(context,listen: false).removeFavourite(movie.id);
                    
                    },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
