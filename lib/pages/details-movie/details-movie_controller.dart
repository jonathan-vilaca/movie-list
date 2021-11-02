import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/shared/services/dio_service.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/utils/validatos.dart';

class DetailsMovieController {
  final _http = CustomHttp();

  movieDetails(String imdbID) async {

    String searchMovie = Validators.validateSearch(imdbID);

    Response response = await _http.client.get(
      '?i=$searchMovie&apikey=$omdbKey'
    );

    Map<String, dynamic> result = await jsonDecode(response.toString());

    return result;
  }
}