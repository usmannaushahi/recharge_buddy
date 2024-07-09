import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/screens/widgets/beneficiary_card.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/screens/widgets/no_beneficiary_widget.dart';

class BeneficiariesList extends StatelessWidget {
  const BeneficiariesList({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double cardSize = width * 0.4;
    return SizedBox(
      height: cardSize,
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          final List<BeneficiaryModel> beneficiaryList =
              state.beneficiaryList ?? [];
          return beneficiaryList.isEmpty
              ? const NoBeneficiaryWidget()
              : ListView.builder(
                  itemCount: beneficiaryList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return BeneficiaryCard(
                      cardSize: cardSize,
                      beneficiaryModel: beneficiaryList[index],
                    );
                  });
        },
      ),
    );
  }
}
