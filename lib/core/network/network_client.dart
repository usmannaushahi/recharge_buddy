import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/http_exception.dart';
import 'network_constants.dart';

class NetworkClient {
  final Dio dio;

  NetworkClient({required this.dio});

  Future<Response> invoke(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    dynamic requestBody,
    bool isBytes = false,
  }) async {
    dio.options.baseUrl = kBaseUrl;

    Response? response;

    if (kDebugMode) {
      log("==================================================================");
      log("URL:   ${dio.options.baseUrl}$url ");
      log("AuthParam: ${queryParameters.toString()}");
      log("Headers: ${headers.toString()}");
      log("RequestType: ${requestType.toString()}");
      log("==================================================================");
    }

    try {
      if (isBytes) {
        response = await dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(
            responseType: ResponseType.bytes,
            headers: headers,
          ),
        );
        return response;
      }
      switch (requestType) {
        case RequestType.get:
          response = await dio.get(url,
              queryParameters: queryParameters,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.post:
          response = await dio.post(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.put:
          response = await dio.put(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.delete:
          response = await dio.delete(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
        case RequestType.patch:
          response = await dio.patch(url,
              queryParameters: queryParameters,
              data: requestBody,
              options:
                  Options(responseType: ResponseType.json, headers: headers));
          break;
      }
      return response;
    } on DioException catch (dioError) {
      log(
        '$runtimeType on DioError:-  $dioError',
      );

      throw ServerException(dioError: dioError);
    }
  }
}

enum RequestType { get, post, put, delete, patch }
