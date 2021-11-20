import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movies_app/shared/services/dio_service.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/utils/loading.dart';
import 'package:movies_app/utils/validatos.dart';

class HomeController {

  final _http = CustomHttp();

  getMovies(String search) async {
    LoadingScreen.loading();
    try{
      String searchMovies = Validators.validateSearch(search);
      List listSearch = [];

      Response response = await _http.client.get(
        '?s=$searchMovies&Type=movie&apikey=$omdbKey'
      );

      Map<String, dynamic> result = await jsonDecode(response.toString());
      listSearch = result['Search'];
      LoadingScreen.loadingClose();

      return listSearch;
    }catch (e) {
      LoadingScreen.loadingClose();
      print(e);
    }
  }

}