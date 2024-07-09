import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recharge_buddy/core/routes/app_routes.dart';
import 'package:recharge_buddy/core/utils/constants.dart';
import 'package:recharge_buddy/core/utils/utilities.dart';

import '../../../../core/enums/enums.dart';
import '../../data/model/beneficiary_model.dart';
part 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  BeneficiaryCubit() : super(const BeneficiaryState());

  //Method to add a single beneficiary
  addSingleBeneficiary(
      {required BeneficiaryModel model, required bool isTopUpSelected}) {
    try {
      ///The user can top up multiple beneficiaries but is limited to a total of AED 3,000 per month for all beneficiaries.
      num currentBalance = state.totalBalance;
      if (currentBalance - model.currentBalance < 1) {
        Utils.toast('You reached your top-up limit. Please recharge');
        return;
      }

      //Emitting loading state
      emit(state.copyWith(BeneficiaryStatus: StatusEnum.loading));

      //Creating copy of existing beneficiaries
      List<BeneficiaryModel> existingList = state.beneficiaryList ?? [];

      //Always inserting at the first index
      existingList.insert(0, model);

      ///The user's balance should be debited first before the top-up transaction is attempted.
      num newBalance = state.totalBalance - model.currentBalance;

      if (isTopUpSelected) {
        newBalance = newBalance - kTopUpCharges;
      }

      //Updating the state after adding the new beneficiary
      emit(state.copyWith(
          beneficiaryList: existingList,
          totalBalance: newBalance,
          BeneficiaryStatus: StatusEnum.success));

      Utils.toast("Beneficiary Added Successfully");
      Navigator.pop(AppRouter.context);
    } catch (e, s) {
      log("Exception addSingleBeneficiary : $e");
      emit(state.copyWith(BeneficiaryStatus: StatusEnum.failure));
    }
  }

  //Method to edit a single beneficiary. Using this method to topUp a user.
  topUpBeneficiary(
      {required BeneficiaryModel model,
      required num topUpValue,
      required bool isTopUpSelected}) {
    try {
      if (!isTopUpSelected) {
        Utils.toast('Please select a top-up');
        return;
      }

      ///The user can top up multiple beneficiaries but is limited to a total of AED 3,000 per month for all beneficiaries.
      num currentBalance = state.totalBalance;
      if (currentBalance - model.currentBalance < 1) {
        Utils.toast('You reached your top-up limit. Please recharge');
        return;
      }

      ///If a user is verified, they can top up a maximum of AED 500 per calendar month per beneficiary.
      if (Utils.isVerifiedUser() && model.currentBalance > 500) {
        Utils.toast('You cannot recharge this user more than 500 per month');
        return;
      }

      ///If a user is not verified, they can top up a maximum of AED 1,000 per calendar month per beneficiary for security reasons.
      else if (!Utils.isVerifiedUser() && model.currentBalance > 1000) {
        Utils.toast('You cannot recharge this user more than 1000 per month');
        return;
      }

      //Emitting loading state
      emit(state.copyWith(BeneficiaryStatus: StatusEnum.loading));

      //Creating copy of existing beneficiaries
      List<BeneficiaryModel> existingList = state.beneficiaryList ?? [];

      //Removing the old model so we can add a fresh one with updated values
      existingList.removeWhere((element) => element.id == model.id);

      //Always inserting at the first index
      existingList.insert(0, model);

      ///The user's balance should be debited first before the top-up transaction is attempted.
      num newBalance = state.totalBalance - topUpValue;

      if (isTopUpSelected) {
        newBalance = newBalance - kTopUpCharges;
      }

      //Updating the state after adding the new beneficiary
      emit(state.copyWith(
          beneficiaryList: existingList,
          totalBalance: newBalance,
          BeneficiaryStatus: StatusEnum.success));

      Utils.toast("Top-Up Added Successfully");
      Navigator.pop(AppRouter.context);
    } catch (e, s) {
      log("Exception topUpBeneficiary : $e");
      emit(state.copyWith(BeneficiaryStatus: StatusEnum.failure));
    }
  }
}
