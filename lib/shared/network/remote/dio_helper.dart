import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

 static Future<Response> getData({
    @required String url,
    @required Map<String , dynamic> query_parameters,
  }) async {
    return await dio.get(url, queryParameters: query_parameters);
    // get(path).. path= methode url
  }
}
