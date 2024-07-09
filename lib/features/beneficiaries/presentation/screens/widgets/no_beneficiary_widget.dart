import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/core/routes/app_routes.dart';
import 'package:recharge_buddy/core/theme/typography.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';

class NoBeneficiaryWidget extends StatelessWidget {
  const NoBeneficiaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "Seems like you do not have any beneficiary",
            style: bodyMedium,
          ),
        ),
        TextButton(
            onPressed: () {
             AppRouter.push(AppRouter.beneficiaryFormRoute);
            },
            child: const Text(
              'Add Now',
              style: bodySmallPrimary,
            ))
      ],
    );
  }
}
