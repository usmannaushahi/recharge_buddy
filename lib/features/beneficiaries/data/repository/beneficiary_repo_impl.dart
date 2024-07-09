import 'package:dartz/dartz.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';
import 'package:recharge_buddy/features/beneficiaries/domain/beneficiary_repository.dart';

import '../../../../core/errors/http_exception.dart';
import '../data_source/beneficiary_datasource.dart';

class BeneficiaryRepoImpl extends BeneficiaryRepository {
  BeneficiaryRepoImpl(this.dataSource);
  final BeneficiaryDataSource dataSource;

  @override
  Future<Either<Exception, Unit>> addBeneficiary(BeneficiaryModel model) async {
    try {
      final response = await dataSource.addBeneficiary(model);
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerException(dioError: exception.dioError));
    }
  }

  @override
  Future<Either<Exception, Unit>> topUpBeneficiary(
      BeneficiaryModel model) async {
    try {
      final response = await dataSource.topUpBeneficiary(model);
      return Right(response);
    } on ServerException catch (exception) {
      return Left(ServerException(dioError: exception.dioError));
    }
  }
}
