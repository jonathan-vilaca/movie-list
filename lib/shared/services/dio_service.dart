import 'package:dio/dio.dart';
import 'package:movies_app/utils/constants.dart';

class CustomHttp {
  final Dio client = Dio();
  CustomHttp() {
    client.options.baseUrl = apiOmdb;
    //client.interceptors.add(CustomInterceptors());
    client.options.connectTimeout = 60000;
  }
}

