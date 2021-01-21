import 'package:dio/dio.dart';

Dio dio = new Dio(new BaseOptions(
    baseUrl: 'https://ec4e8b422e4d.ngrok.io',
    receiveDataWhenStatusError: true,
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
}
