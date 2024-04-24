class GroupActor {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;
  GroupActor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory GroupActor.fromJson(Map actor) {
    return GroupActor(
        adult: bool.parse(actor['adult'].toString()),
        gender: int.parse(actor['gender'].toString()),
        id: int.parse(actor['id'].toString()),
        knownForDepartment: actor['known_for_department'].toString(),
        name: actor['name'].toString(),
        originalName: actor['original_name'].toString(),
        popularity: double.parse(actor['popularity'].toString()),
        profilePath: actor['profile_path'].toString(),
        castId: int.parse(actor['cast_id'].toString()),
        character: actor['character'].toString(),
        creditId: actor['credit_id'].toString(),
        order: int.parse(actor['order'].toString()),);

    //  "adult": false,
    //       "gender": 2,
    //       "id": 8984,
    //       "known_for_department": "Acting",
    //       "name": "Bill Pullman",
    //       "original_name": "Bill Pullman",
    //       "popularity": 35.608,
    //       "profile_path": "/AlLhgmcX5zh3frPT82OSPY9gqXO.jpg",
    //       "cast_id": 2,
    //       "character": "Fred Madison",
    //       "credit_id": "52fe4262c3a36847f801a263",
    //       "order": 0
  }
}

class Actor {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  final DateTime birthDate;
  final DateTime? deathDate;
  final int gender;
  final String? homePage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;
  Actor({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthDate,
    required this.deathDate,
    required this.gender,
    required this.homePage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
  });

  factory Actor.fromJson(Map actor) {
    return Actor(
        adult: bool.parse(actor['adult'].toString()),
        gender: int.parse(actor['gender'].toString()),
        id: int.parse(actor['id'].toString()),
        knownForDepartment: actor['known_for_department'].toString(),
        name: actor['name'].toString(),
       alsoKnownAs: (actor["also_known_as"]as List<dynamic>).cast<String>(),
       biography: actor['biography'].toString(),
       birthDate: DateTime.parse(actor['birthday'].toString()),
       deathDate: actor['deathday']==null?null: DateTime.parse(actor['deathday'].toString()),
       homePage: actor['homepage'].toString(),
       imdbId:actor['imdb_id'].toString() ,
       placeOfBirth: actor["place_of_birth"].toString(),
        popularity: double.parse(actor['popularity'].toString()),
        profilePath: actor['profile_path'].toString(),
      );

    //  "adult": false,
    //       "gender": 2,
    //       "id": 8984,
    //       "known_for_department": "Acting",
    //       "name": "Bill Pullman",
    //       "original_name": "Bill Pullman",
    //       "popularity": 35.608,
    //       "profile_path": "/AlLhgmcX5zh3frPT82OSPY9gqXO.jpg",
    //       "cast_id": 2,
    //       "character": "Fred Madison",
    //       "credit_id": "52fe4262c3a36847f801a263",
    //       "order": 0
  }
}
