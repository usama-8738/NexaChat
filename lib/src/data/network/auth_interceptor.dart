import "package:dio/dio.dart";

import '../datasources/local/session_store.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._sessionStore);

  final SessionStore _sessionStore;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _sessionStore.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
