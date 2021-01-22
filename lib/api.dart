import 'dart:io';

import 'package:dio/dio.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: 'https://cdec1ffd0e01.ngrok.io',
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
    return await dio.get(path,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> getDepartments(String token) async {
    String path = '/libs/departments';
    return await dio.get(path,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> getPositions(String token) async {
    String path = '/libs/positions';
    return await dio.get(path,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> saveEmployee(
      String firstName,
      String lastName,
      String birthdate,
      String sex,
      int departmentId,
      int positionId,
      String token) async {
    String path = '/employees';
    return await dio.post(path,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "birthdate": birthdate,
          "sex": sex,
          "departmentId": departmentId.toString(),
          "positionId": positionId.toString()
        },
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }
}
