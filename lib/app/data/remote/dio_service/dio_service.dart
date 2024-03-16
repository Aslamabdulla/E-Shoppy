import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:e_shoppy/app/data/remote/api_service/api_service.dart';
import 'package:e_shoppy/utils/end_points/end_points.dart';

class DioService extends ApiService {
  factory DioService() => _instance;

  DioService._internal() {
    _initializeDio();
  }

  static final DioService _instance = DioService._internal();

  final Dio _dio = Dio();

  Dio get dioInstance => _dio;

  void _initializeDio() {
    _dio.options = BaseOptions(
      baseUrl: Endpoints.baseUri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  @override
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    // TODO: implement delete
    return Response(requestOptions: RequestOptions());
  }

  @override
  Future<Response> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);

      return response;
    } on DioException catch (e) {
      return Response(
        requestOptions: RequestOptions(),
        statusCode: e.response?.statusCode,
        data: null,
      );
    }
  }

  @override
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    // TODO: implement post
    return Response(requestOptions: RequestOptions());
  }
}
