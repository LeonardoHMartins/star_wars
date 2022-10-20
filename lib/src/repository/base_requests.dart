import 'package:dio/dio.dart';

class BaseRequests {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://swapi.dev/api/'));

  Future getSomething(url) async {
    var response = await dio.get(url);
    return response.data;
  }
}
