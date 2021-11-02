import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/shared/services/dio_service.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/utils/validatos.dart';

class HomeController {

  final _http = CustomHttp();

  getMovies(String search) async {
    String searchMovies = Validators.validateSearch(search);
    List listSearch = [];

    Response response = await _http.client.get(
      '?s=$searchMovies&Type=movie&apikey=$omdbKey'
    );

    Map<String, dynamic> result = await jsonDecode(response.toString());
    listSearch = result['Search'];

    return listSearch;
  }

}