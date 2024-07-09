import 'package:dio/dio.dart';
import 'package:recharge_buddy/core/network/network_constants.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';

import '../../../../core/errors/http_exception.dart';
import '../../../../core/network/network_client.dart';

class BeneficiaryDataSource {
  final NetworkClient networkClient;

  BeneficiaryDataSource(this.networkClient);

  Future<dynamic> addBeneficiary(BeneficiaryModel model) async {
    var response = await networkClient
        .invoke(kAddBeneficiaryAPI, RequestType.post, requestBody: model);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw ServerException(
        dioError: DioException(
          error: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }

  Future<dynamic> topUpBeneficiary(BeneficiaryModel model) async {
    var response = await networkClient
        .invoke(kTopUpBeneficiaryAPI, RequestType.put, requestBody: model);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw ServerException(
        dioError: DioException(
          error: response,
          type: DioExceptionType.badResponse,
          requestOptions: response.requestOptions,
        ),
      );
    }
  }
}
