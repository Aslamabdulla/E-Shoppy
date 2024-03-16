import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters});
  Future<Response> post(String endpoint, {Map<String, dynamic>? data});

  Future<Response> delete(String endpoint, {Map<String, dynamic>? data});
}
