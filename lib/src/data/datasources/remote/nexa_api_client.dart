import "package:dio/dio.dart";

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';

class NexaApiClient {
  NexaApiClient(this._dio);

  final Dio _dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    try {
      return await _dio.get<T>(path, queryParameters: query);
    } on DioException catch (error, stackTrace) {
      throw ServerException(error.message ?? 'Request failed', stackTrace: stackTrace, statusCode: error.response?.statusCode);
    }
  }

  Future<Response<T>> post<T>(String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      return await _dio.post<T>(path, data: data, queryParameters: query);
    } on DioException catch (error, stackTrace) {
      throw ServerException(error.message ?? 'Request failed', stackTrace: stackTrace, statusCode: error.response?.statusCode);
    }
  }

  Future<Response<T>> put<T>(String path, {Object? data}) async {
    try {
      return await _dio.put<T>(path, data: data);
    } on DioException catch (error, stackTrace) {
      throw ServerException(error.message ?? 'Request failed', stackTrace: stackTrace, statusCode: error.response?.statusCode);
    }
  }

  Future<Response<T>> delete<T>(String path, {Object? data}) async {
    try {
      return await _dio.delete<T>(path, data: data);
    } on DioException catch (error, stackTrace) {
      throw ServerException(error.message ?? 'Request failed', stackTrace: stackTrace, statusCode: error.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> getJson(String path, {Map<String, dynamic>? query}) async {
    final response = await get<Map<String, dynamic>>(path, query: query);
    return _asJson(response);
  }

  Future<List<Map<String, dynamic>>> getJsonList(String path, {Map<String, dynamic>? query}) async {
    final response = await get<List<dynamic>>(path, query: query);
    return _asJsonList(response);
  }

  Future<Map<String, dynamic>> postJson(String path, {Object? data, Map<String, dynamic>? query}) async {
    final response = await post<Map<String, dynamic>>(path, data: data, query: query);
    return _asJson(response);
  }

  Future<void> postVoid(String path, {Object? data, Map<String, dynamic>? query}) async {
    await post<dynamic>(path, data: data, query: query);
  }

  Future<Map<String, dynamic>> putJson(String path, {Object? data}) async {
    final response = await put<Map<String, dynamic>>(path, data: data);
    return _asJson(response);
  }

  Future<void> deleteVoid(String path, {Object? data}) async {
    await delete<dynamic>(path, data: data);
  }

  static BaseOptions defaultOptions(Uri baseApiUrl) => BaseOptions(
        baseUrl: baseApiUrl.resolve(ApiConstants.restBasePath).toString(),
        connectTimeout: ApiConstants.defaultConnectTimeout,
        receiveTimeout: ApiConstants.defaultReceiveTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

  Map<String, dynamic> _asJson(Response response) {
    final data = response.data;
    if (data is Map<String, dynamic>) {
      return data;
    }
    throw ServerException('Expected JSON object but got ${data.runtimeType}', statusCode: response.statusCode);
  }

  List<Map<String, dynamic>> _asJsonList(Response response) {
    final data = response.data;
    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList();
    }
    throw ServerException('Expected JSON array but got ${data.runtimeType}', statusCode: response.statusCode);
  }
}
