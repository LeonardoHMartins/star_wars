import 'package:flutter/foundation.dart';
import 'package:starwars_w2o/src/models/films.dart';
import 'package:starwars_w2o/src/repository/base_requests.dart';

class FilmsRequests extends BaseRequests {
  Future getAllFilms() async {
    try {
      var response = await getSomething('https://swapi.dev/api/films');
      return response;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Exception(err);
    }
  }

  trasformingFilms(List<dynamic> filmsMap) {
    List<Films> listfilmsMap = [];

    listfilmsMap = filmsMap.map((e) => Films.fromMap(e)).toList();
    return listfilmsMap;
  }
}
