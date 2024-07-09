import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/core/enums/enums.dart';
import 'package:recharge_buddy/core/theme/app_colors.dart';
import 'package:recharge_buddy/core/theme/typography.dart';
import 'package:recharge_buddy/core/utils/constants.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/screens/widgets/beneficiaries_list.dart';

class BeneficiariesScreen extends StatelessWidget {
  const BeneficiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
              buildWhen: (context, state) =>
                  state.addBeneficiaryStatus == StatusEnum.loading ||
                  state.addBeneficiaryStatus == StatusEnum.success,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Available Credit : ',
                        style: titleLarge,
                      ),
                      Text(
                        '$kCurrency ${state.totalBalance.toStringAsFixed(2)}',
                        style: titleLargeBlack,
                      )
                    ],
                  ),
                );
              },
            ),
            const Divider(
              color: AppColors.gray,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "My Beneficiaries",
                style: bodyLargePrimary,
              ),
            ),
            const BeneficiariesList()
          ],
        ),
      ),
    );
  }
}
