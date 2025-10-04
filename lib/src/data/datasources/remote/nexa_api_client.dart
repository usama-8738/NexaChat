import "package:dio/dio.dart";

import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exceptions.dart';

class NexaApiClient {
  // TODO(ai): Route inference requests through the orchestration microservice when LLM APIs are wired up.
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

  static BaseOptions defaultOptions(Uri baseApiUrl) => BaseOptions(
        baseUrl: baseApiUrl.resolve(ApiConstants.restBasePath).toString(),
        connectTimeout: ApiConstants.defaultConnectTimeout,
        receiveTimeout: ApiConstants.defaultReceiveTimeout,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
}

