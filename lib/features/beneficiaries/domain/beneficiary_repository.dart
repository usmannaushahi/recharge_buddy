import 'package:dartz/dartz.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';

abstract class BeneficiaryRepository {
  Future<Either<Exception, Unit>> addBeneficiary(BeneficiaryModel model);

  Future<Either<Exception, Unit>> topUpBeneficiary(BeneficiaryModel model);
}
