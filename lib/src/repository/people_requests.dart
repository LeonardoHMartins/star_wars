import 'package:flutter/foundation.dart';
import 'package:starwars_w2o/src/models/people.dart';
import 'package:starwars_w2o/src/repository/base_requests.dart';

class PeopleRequests extends BaseRequests {
  Future getAllPeoples() async {
    try {
      var response = await getSomething('https://swapi.dev/api/people');
      return response;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Exception(err);
    }
  }

  Future getPeople(value) async {
    try {
      var response =
          await getSomething('https://swapi.dev/api/people/?search=$value');
      return response;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw Exception(err);
    }
  }

  trasformingPeoples(List<dynamic> peoplesMap) {
    List<People> listPeoplesMap = [];

    listPeoplesMap = peoplesMap.map((e) => People.fromMap(e)).toList();
    return listPeoplesMap;
  }
}
