import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:parky/core/api/api_consumer.dart';
import 'package:parky/core/utils/functions/kprint.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../helpers/cache_helper.dart';

/// This class is responsible for handling api calls using Dio package
class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      // ignore: deprecated_member_use
      onHttpClientCreate: (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      },
    );

    dio.options = BaseOptions(
      baseUrl: 'https://gradyproject-production.up.railway.app',
      receiveDataWhenStatusError: true,
      sendTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 40),
      connectTimeout: const Duration(seconds: 40),
      headers: {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "GET,PUT,POST,DELETE,PATCH,OPTIONS",
      },
    );

    dio.interceptors.addAll(
      [
        // For logging request & response
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90,
        ),

        InterceptorsWrapper(
          onRequest: (options, handler) async {
            // For token handling
            final token = CacheHelper.getStringData('token');

            if (token != null) {
              // Set the Authorization header with the cached access token
              kprint("Token: $token");
              options.headers['Authorization'] = 'Bearer $token';
            }

            return handler.next(options);
          },
        ),
        // onResponse: (response, handler) {
        //   return handler.next(response);
        // },
        //   onError: (error, handler) {
        //     kprint("Error from DioConsumer: ${error.toString()}");

        //     if (error.response?.statusCode == APIResponseCodes.unauthorized ||
        //         error.response?.statusCode == APIResponseCodes.forbidden) {
        //       // User is unauthorized or forbidden

        //       // Clear cashed data

        //       // Navigate to login page
        //       RouteManager.navigatorKey.currentState!.pushNamedAndRemoveUntil(
        //         PageName.loginScreen,
        //         (route) => false,
        //       );
        //     } else {
        //       return handler.next(error);
        //     }
        //   },
        // ),
      ],
    );
  }

  @override
  Future get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  @override
  Future patch({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.patch(
      path,
      data: body,
    );

    return response.data;
  }

  @override
  Future post({
    required String path,
    bool isFormData = false,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.post(
      path,
      data: isFormData ? FormData.fromMap(body!) : body,
    );

    return response.data;
  }

  @override
  Future put({
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) {
    throw UnimplementedError();
  }

  @override
  Future delete({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final resposne = await dio.delete(
      path,
      queryParameters: queryParameters,
    );

    return resposne.data;
  }
}
