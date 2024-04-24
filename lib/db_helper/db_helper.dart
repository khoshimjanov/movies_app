// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  final String name = 'db';
  static Future<sql.Database> database() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(
        path.join(dbPath, 'movieuser.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE user(id TEXT,name TEXT);',
          );
        },
        version: 1,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<sql.Database> movieDatabase() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(
        path.join(dbPath, 'movies.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE favourite(id INT);',
          );
        },
        version: 1,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<sql.Database> movieListDatabase() async {
    try {
      final dbPath = await sql.getDatabasesPath();
      return sql.openDatabase(
        path.join(dbPath, 'movieslist.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE movielist(id INT);',
          );
        },
        version: 1,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logIn() async {
    try {
      final db = await DBHelper.database();
      db.insert('user', {});
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map<String, Object?>?> getData() async {
    try {
      final db = await DBHelper.database();
      final data = await db.query('user');
      if (data.isEmpty) {
        return null;
      }


      final sentData = data[0];
      return sentData;
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> update(String name) async {
    try {
      final db = await DBHelper.database();
      db.delete('user');
      db.insert('user', {'id': '1', 'name': name});
      // db.rawUpdate(
      //   "UPDATE user SET  name=?,WHERE id = ?",
      //   [name, '1'],
      // );
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> addFavourite(
    int id,
  ) async {
    try {
      final db = await DBHelper.movieDatabase();

      db.insert('favourite', {
        "id": id,
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> removeFavourite(
    int id,
  ) async {
    try {
      final db = await DBHelper.movieDatabase();

      db.delete('favourite', where: 'id=$id', whereArgs: [id]);
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> addMovieList(
    int id,
  ) async {
    try {
      final db = await DBHelper.movieListDatabase();

      db.insert('movielist', {
        "id": id,
      });
    } catch (error) {
      rethrow;
    }
  }

  static Future<void> removeMovieList(
    int id,
  ) async {
    try {
      final db = await DBHelper.movieListDatabase();

      db.delete('movielist', where: 'id=$id', whereArgs: [id]);
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Map<String, Object?>>> getFavMovies() async {
    try {
      final db = await DBHelper.movieDatabase();
      final data = await db.query('favourite');
      if (data.isEmpty) {
        return [];
      }

      return data;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<Map<String, Object?>>> getMovieList() async {
    try {
      final db = await DBHelper.movieListDatabase();
      final data = await db.query('movielist');
      if (data.isEmpty) {
        return [];
      }

      return data;
    } catch (error) {
      rethrow;
    }
  }
}
