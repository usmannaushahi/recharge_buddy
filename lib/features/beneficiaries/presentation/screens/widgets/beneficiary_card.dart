import 'package:flutter/material.dart';
import 'package:recharge_buddy/core/common_widgets/common_rounded_button.dart';
import 'package:recharge_buddy/core/routes/app_routes.dart';
import 'package:recharge_buddy/core/theme/typography.dart';
import 'package:recharge_buddy/features/beneficiaries/data/model/beneficiary_model.dart';

class BeneficiaryCard extends StatelessWidget {
  final BeneficiaryModel beneficiaryModel;
  final double? cardSize;
  const BeneficiaryCard(
      {super.key, required this.beneficiaryModel, this.cardSize});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cardSize,
      height: cardSize,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                beneficiaryModel.name,
                overflow: TextOverflow.ellipsis,
                style: bodySmall,
              ),
              Text(
                beneficiaryModel.countryCode + beneficiaryModel.phoneNumber,
                overflow: TextOverflow.ellipsis,
                style: bodySmall,
              ),
              CommonRoundedButton(
                  text: "Recharge Now",
                  onPressed: () {
                    AppRouter.push(AppRouter.beneficiaryFormRoute,
                        extra: beneficiaryModel);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
