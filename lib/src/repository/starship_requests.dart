import 'package:flutter/foundation.dart';
import 'package:starwars_w2o/src/models/starships.dart';
import 'package:starwars_w2o/src/repository/base_requests.dart';

class StarshipsRequests extends BaseRequests {
  Future getAllStarships() async {
    try {
      var response = await getSomething('https://swapi.dev/api/starships');
      return response;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Exception(err);
    }
  }

  trasformingStarships(List<dynamic> starshipMap) {
    List<Starships> listStarships = [];

    listStarships = starshipMap.map((e) => Starships.fromMap(e)).toList();
    return listStarships;
  }
}
