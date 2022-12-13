import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/onBoarding/onboarding.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class DioHelper {
  static Dio dio;
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> getData({
    @required String url,
    //required Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.get(url);
  }

  static Future<Response> postData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    @required String url,
    Map<String, dynamic> query,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) async {
    dio?.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.put(url, queryParameters: query, data: data);
  }
}
