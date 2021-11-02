import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/shared/services/dio_service.dart';
import 'package:movies_app/utils/constants.dart';

class HomeController {

  final _http = CustomHttp();

  getMovies(String search) async {
    String searchMovie = validateSearch(search);
    List listSearch = [];

    Response response = await _http.client.get(
      '?s=$searchMovie&Type=movie&apikey=$omdbKey'
    );

    Map<String, dynamic> result = await jsonDecode(response.toString());
    listSearch = result['Search'];

    return listSearch;
  }

  validateSearch(String value) {
    return value.replaceAll(' ', '+');
  }

}