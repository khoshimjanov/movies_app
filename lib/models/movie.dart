import 'package:movies_app/models/company.dart';
import 'package:movies_app/models/country.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/language.dart';
import 'package:movies_app/models/movie_collection.dart';

class Movie {
  final String title;
  final int id;
  final String backdropPath;
  final String imdbId;
  final bool adult;
  final String originalTitle;
  final String originalLanguage;
  final List<Language> spokenLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final MovieCollection? belongsToCollection;
  final int budget;
  final String homePage;
  final List<Company> productionCompanies;
  final List<Country> productionCountries;
  final int runTime;
  final String status;
  final String tagline;

  Movie({
    required this.title,
    required this.id,
    required this.adult,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homePage,
    required this.imdbId,
    required this.originalLanguage,
    required this.productionCompanies,
    required this.productionCountries,
    required this.runTime,
    required this.spokenLanguage,
    required this.status,
    required this.tagline,
  });

  factory Movie.fromJson(Map<dynamic, dynamic> movie) {
    final collection = movie['belongs_to_collection'] == null
        ? null
        : movie['belongs_to_collection'] as Map;

    final MovieCollection? movieCollection = collection == null
        ? null
        : MovieCollection(
            id: collection['id'].toString(),
            name: collection['name'].toString(),
            posterPath: collection['posterPath'].toString(),
            backdropPath: collection['backdropPath'].toString(),
          );
    final genres =
        (movie['genres'] as List<dynamic>).cast<Map<dynamic, dynamic>>();

    final List<Genre> newgenres = [];
    for (final i in genres) {
      newgenres.add(
        Genre(
          id: int.parse(i['id'].toString()),
          name: i['name'].toString(),
        ),
      );
    }
    final productionCompanies = (movie['production_companies'] as List<dynamic>)
        .cast<Map<dynamic, dynamic>>();
    final List<Company> companies = [];
    for (final i in productionCompanies) {
      companies.add(Company(
          id: int.parse(i['id'].toString()),
          name: i['name'].toString(),
          logoPath: i['logo_path'].toString(),
          originCountry: i['origin_country'].toString(),),);
    }
    final productionCountries = (movie['production_countries'] as List<dynamic>)
        .cast<Map<dynamic, dynamic>>();
    final List<Country> countries = [];
    for (final i in productionCountries) {
      countries.add(Country(
          isoName: i['iso_639_1'].toString(), name: i['name'].toString(),),);
    }
    final spokenLanguage = (movie['spoken_languages'] as List<dynamic>)
        .cast<Map<dynamic, dynamic>>();
    final List<Language> languages = [];
    for (final i in spokenLanguage) {
      languages.add(
        Language(
          englishName: i['english_name'].toString(),
          isoName: i['iso_639_1'].toString(),
          name: i['name'].toString(),
        ),
      );
    }

    final newMovie = Movie(
      title: movie["title"].toString(),
      id: int.parse(movie["id"].toString()),
      adult: bool.parse(movie['adult'].toString()),
      originalTitle: movie['original_title'].toString(),
      overview: movie['overview'].toString(),
      posterPath: movie['poster_path'].toString(),
      popularity: double.parse(movie['popularity'].toString()),
      releaseDate: DateTime.parse(movie['release_date'].toString()),
      video: bool.parse(movie['video'].toString()),
      voteAverage: double.parse(movie['vote_average'].toString()),
      voteCount: int.parse(movie['vote_count'].toString()),
      backdropPath: movie['backdrop_path'].toString(),
      belongsToCollection: movieCollection,
      budget: int.parse(movie['budget'].toString()),
      genres: newgenres,
      homePage: movie['homepage'].toString(),
      imdbId: movie['imdb_id'].toString(),
      originalLanguage: movie["original_language"].toString(),
      productionCompanies: companies,
      productionCountries: countries,
      runTime: int.parse(movie['runtime'].toString()),
      spokenLanguage: languages,
      status: movie['status'].toString(),
      tagline: movie['tagline'].toString(),
    );

    return newMovie;
  }
}

class GroupMovie {
  final String title;
  final int id;
  final String? backdropPath;
  final bool adult;
  final String originalTitle;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String? posterPath;
  final DateTime? releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;

  GroupMovie({
    required this.title,
    required this.id,
    required this.adult,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.popularity,
    required this.releaseDate,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.backdropPath,
    required this.genreIds,
    required this.originalLanguage,
  });
  factory GroupMovie.fromJson(Map<dynamic, dynamic> movie) {
    return GroupMovie(
      title: movie["title"].toString(),
      id: int.parse(movie["id"].toString()),
      adult: bool.parse(movie['adult'].toString()),
      originalTitle: movie['original_title'].toString(),
      overview: movie['overview'].toString(),
      posterPath: movie['poster_path'].toString(),
      popularity: double.parse(movie['popularity'].toString()),
      releaseDate: null,
      //  movie['release_date'] == null
      //     ? DateTime.now()
      //     : DateTime.parse(movie['release_date'].toString()),
      video: bool.parse(movie['video'].toString()),
      voteAverage: double.parse(movie['vote_average'].toString()),
      voteCount: int.parse(movie['vote_count'].toString()),
      backdropPath: movie['backdrop_path'].toString(),
      genreIds: (movie['genre_ids'] as List<dynamic>).cast<int>(),
      originalLanguage: movie["original_language"].toString(),
    );
  }
}
