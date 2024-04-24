import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/db_helper/db_helper.dart';
import 'package:movies_app/models/actor.dart';
import '../models/movie.dart';

class Movies with ChangeNotifier {
  final String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMDA4OWI0MDAwMzlmN2I5NThmZDkwYzlhM2RmYWUwMSIsInN1YiI6IjYwZGZmZjBmMzQ0YThlMDA3NTNlN2Q4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.4mWuAlIp7XOCp0mgUaElZeSnwyrrpMCJ938g7yDcGr8';
  final String apiKey = "20089b400039f7b958fd90c9a3dfae01";

  final List<Movie> _favMovies = [];
  List<Movie> get favMovies {
    return _favMovies;
  }

  final List<Movie> _listMovies = [];
  List<Movie> get listMovies {
    return _listMovies;
  }

  final List<GroupMovie> _searchedMovies = [];
  List<GroupMovie> get searchedMovies {
    return _searchedMovies;
  }

  final List<int> favouriteMovies = [];
  final List<int> watchList = [];

  void addFavourite(int id) {
    if (favouriteMovies.contains(id)) {
      favouriteMovies.remove(id);
      DBHelper.removeFavourite(id);
      notifyListeners();
      return;
    }
    favouriteMovies.add(id);
    DBHelper.addFavourite(id);
    notifyListeners();
  }

  void addWatchList(int id) {
    if (watchList.contains(id)) {
      watchList.remove(id);
      DBHelper.removeMovieList(id);
      notifyListeners();
      return;
    }
    watchList.add(id);
    DBHelper.addMovieList(id);
    notifyListeners();
  }

  void removeWatchList(int id) {
    watchList.remove(id);
    _listMovies.removeWhere((element) => element.id == id);
    DBHelper.removeMovieList(id);
    notifyListeners();
  }

  void removeFavourite(int id) {
    favouriteMovies.remove(id);
    _favMovies.removeWhere((element) => element.id == id);
    DBHelper.removeFavourite(id);
    notifyListeners();
  }

  Future<void> getFavListMovies() async {
    final favMovies = await DBHelper.getFavMovies();
    for (final i in favMovies) {
      if (favouriteMovies.contains(int.parse(i['id'].toString()))) continue;
      favouriteMovies.add(int.parse(i['id'].toString()));
    }
    final moviesList = await DBHelper.getMovieList();
    for (final i in moviesList) {
      if (watchList.contains(int.parse(i['id'].toString()))) continue;

      watchList.add(int.parse(i['id'].toString()));
    }
    notifyListeners();
  }

  Future<List<GroupMovie>> getTrendingMovies() async {
    try {
      final String url =
          'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );

      final body = jsonDecode(response.body) as Map;
      final result =
          (body['results'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
      final List<GroupMovie> movies = [];
      for (final Map<dynamic, dynamic> i in result) {
        final newGroupMovie = GroupMovie.fromJson(i);
        movies.add(newGroupMovie);
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupMovie>> getUpcomingMovies() async {
    try {
      final url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );

      final body = jsonDecode(response.body) as Map;
      final result =
          (body['results'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
      final List<GroupMovie> movies = [];
      for (final Map<dynamic, dynamic> i in result) {
        final newGroupMovie = GroupMovie.fromJson(i);
        movies.add(newGroupMovie);
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupMovie>> searchMovies(String name) async {
    try {
      final url =
          'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$name';
      // final url="https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$name";
      //  final       url = 'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );

      final body = jsonDecode(response.body) as Map;
      final result =
          (body['results'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
      final List<GroupMovie> movies = [];
      for (final Map<dynamic, dynamic> i in result) {
        final newGroupMovie = GroupMovie.fromJson(i);
        movies.add(newGroupMovie);
      }
      return movies;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupMovie>> getGenreMovies(int genreId) async {
    try {
      final List<GroupMovie> genreMovies = [];
      final String url =
          "https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId";

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );

      final body = jsonDecode(response.body) as Map;
      final movies =
          (body['results'] as List<dynamic>).cast<Map<dynamic, dynamic>>();

      for (final Map<dynamic, dynamic> i in movies) {
        genreMovies.add(GroupMovie.fromJson(i));
      }

      return genreMovies;
    } catch (e) {
      rethrow;
    }
  }

  Future<Movie> getMovie(int id) async {
    try {
      final String url =
          'https://api.themoviedb.org/3/movie/$id?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      ).timeout(const Duration(seconds: 1));
      // response.body.c
      final client = HttpClient();
      client.connectionTimeout = const Duration(seconds: 5);
      final body = jsonDecode(response.body) as Map;
      return Movie.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<GroupActor>> getCast(int id) async {
    try {
      final url =
          "https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey";
      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );
      final body = jsonDecode(response.body) as Map;
      final data = body['cast'] as List;
      final List<GroupActor> cast = [];
      for (final i in data) {
        cast.add(GroupActor.fromJson(i as Map));
      }
      return cast;
    }catch (e) {
      rethrow;
    }
  }

  Future<List<GroupMovie>> getRecommendedMovies(int id) async {
    try {
      final url =
          'https://api.themoviedb.org/3/movie/$id/similar?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );
      final body = jsonDecode(response.body) as Map;
      final movies =
          (body['results'] as List<dynamic>).cast<Map<dynamic, dynamic>>();
      final List<GroupMovie> recommendedMovies = [];
      for (final Map<dynamic, dynamic> i in movies) {
        final newGroupMovie = GroupMovie.fromJson(i);
        recommendedMovies.add(newGroupMovie);
      }

      return recommendedMovies;
    } catch (e) {
      rethrow;
    }
  }

//   Future<List<Movie>> getListMovies() async {
//     try {
//       final List<Movie> listMovies = [];

//       final watchListString = watchList.join(',');
//       if (watchList.isNotEmpty) {
//         for (final i in watchList) {
//           final String url =
//               'https://api.themoviedb.org/3/movie/$i?api_key=$apiKey';
//           // 'https://api.themoviedb.org/3/movie?api_key=$apiKey&id=$watchListString';

//           final response = await http.get(
//             Uri.parse(url),
//             headers: {'token': token},
//           );
//           final body = jsonDecode(response.body) as Map;
// // // for (final i in body) {
//           listMovies.add(Movie.fromJson(body));
//         }
//       }
//       // notifyListeners();

//       return listMovies;
//       // if (favMovies.isNotEmpty) {

//       // }
//     } catch (e) {
//       rethrow;
//     }
//   }

  Future<List<Movie>> getListMovies() async {
    try {
      final List<Movie> listMovies = [];
      for (final i in watchList) {
        final String url =
            'https://api.themoviedb.org/3/movie/$i?api_key=$apiKey';

        final response = await http.get(
          Uri.parse(url),
          headers: {'token': token},
        );
        final body = jsonDecode(response.body) as Map;

        final newMovie = Movie.fromJson(body);

        listMovies.add(newMovie);
      }

      return listMovies;
    } catch (e) {
      rethrow;
    }
}

  Future<List<Movie>> getFavMovies() async {
    try {
      final List<Movie> favMovies = [];

      for (final i in favouriteMovies) {
        final String url =
            'https://api.themoviedb.org/3/movie/$i?api_key=$apiKey';

        final response = await http.get(
          Uri.parse(url),
          headers: {'token': token},
        );
        final body = jsonDecode(response.body) as Map;

        final newMovie = Movie.fromJson(body);
        if (favMovies.contains(newMovie)) {
          continue;
        }
        favMovies.add(newMovie);
      }
      return favMovies;
    } catch (e) {
      rethrow;
    }
  }

  Future<Actor> getActor(int id) async {
    try {
      final String url =
          'https://api.themoviedb.org/3/person/$id?api_key=$apiKey';

      final response = await http.get(
        Uri.parse(url),
        headers: {'token': token},
      );
      final body = jsonDecode(response.body) as Map;
      return Actor.fromJson(body);
    } catch (e) {
      rethrow;
    }
  }
}
