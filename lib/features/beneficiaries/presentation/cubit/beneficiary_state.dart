part of 'beneficiary_cubit.dart';

class BeneficiaryState extends Equatable {
  final StatusEnum beneficiaryStatus;
  final StatusEnum addBeneficiaryStatus;
  final String? message;
  final List<BeneficiaryModel>? beneficiaryList;
  final num totalBalance;

  const BeneficiaryState(
      {this.addBeneficiaryStatus = StatusEnum.initial,
      this.beneficiaryStatus = StatusEnum.initial,
      this.beneficiaryList,
      this.totalBalance = kTopUpLimit,
      this.message});

  BeneficiaryState copyWith({
    StatusEnum? beneficiaryStatus,
    StatusEnum? BeneficiaryStatus,
    List<BeneficiaryModel>? beneficiaryList,
    String? message,
    num? totalBalance,
  }) {
    return BeneficiaryState(
      beneficiaryStatus: beneficiaryStatus ?? this.beneficiaryStatus,
      addBeneficiaryStatus: BeneficiaryStatus ?? this.addBeneficiaryStatus,
      message: message ?? this.message,
      beneficiaryList: beneficiaryList ?? this.beneficiaryList,
      totalBalance: totalBalance ?? this.totalBalance,
    );
  }

  @override
  List<Object?> get props => [
        beneficiaryStatus,
        addBeneficiaryStatus,
        message,
        beneficiaryList,
        totalBalance
      ];
}
