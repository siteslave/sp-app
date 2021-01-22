import 'dart:io';

import 'package:dio/dio.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: 'https://92b1be27fb3b.ngrok.io',
    receiveDataWhenStatusError: false,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000));

class Api {
  Api();

  Future<Response> login(String username, String password) async {
    String path = '/login';
    return await dio.post(path, data: {
      "username": username,
      "password": password,
    });
  }

  Future<Response> getEmployees(String token) async {
    String path = '/employees';
    return await dio.get(path, options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> getDepartments(String token) async {
    String path = '/libs/departments';
    return await dio.get(path, options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> getPositions(String token) async {
    String path = '/libs/positions';
    return await dio.get(path, options: Options(headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }
}
