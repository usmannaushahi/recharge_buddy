import 'package:dio/dio.dart';

enum ErrorType {
  noInternet,
  badRequest,
  unauthorised,
  forbidden,
  success,
  dataParsing,
  other
}

class ServerException implements Exception {
  late DioException dioError;
  late String? message;
  final bool? payByAPI;
  late ErrorType? errorType;

  ServerException(
      {required this.dioError, this.message, this.errorType, this.payByAPI});

  ServerException.withException({required DioError dioError, this.payByAPI});
}
