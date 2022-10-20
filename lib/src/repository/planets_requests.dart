import 'package:flutter/foundation.dart';
import 'package:starwars_w2o/src/models/planets.dart';
import 'package:starwars_w2o/src/repository/base_requests.dart';

class PlanetsRequests extends BaseRequests {
  Future getAllPlanets() async {
    try {
      var response = await getSomething('https://swapi.dev/api/planets');
      return response;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Exception(err);
    }
  }

  trasformingPlanets(List<dynamic> planetsMap) {
    List<Planets> listPlanets = [];

    listPlanets = planetsMap.map((e) => Planets.fromMap(e)).toList();
    return listPlanets;
  }
}
