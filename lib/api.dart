import 'dart:io';
import 'package:path/path.dart';

import 'package:dio/dio.dart';


Dio dio = new Dio(new BaseOptions(
    baseUrl: 'https://5b32a5b16b98.ngrok.io',
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

  Future<Response> removeEmployee(int employeeId, String token) async {
    String path = '/employees/$employeeId';
    return await dio.delete(path,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> getInfo(int employeeId, String token) async {
    String path = '/employees/$employeeId';
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
      double lat,
      double lng,
      String token) async {
    String path = '/employees';
    return await dio.post(path,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "birthdate": birthdate,
          "sex": sex,
          "departmentId": departmentId.toString(),
          "positionId": positionId.toString(),
          "lat": lat.toString(),
          "lng": lng.toString(),
        },
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }

  Future<Response> uploadImage(
      int employeeId, File imageFile, String token) async {
    String path = '/employees/$employeeId/upload';

    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(imageFile.path, filename: basename(imageFile.path))
    });

    return await dio.post(path,
    data: formData,
        options: Options(
            headers: {HttpHeaders.authorizationHeader: 'Bearer $token'}));
  }
}
