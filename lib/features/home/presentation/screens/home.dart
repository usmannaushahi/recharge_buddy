import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/core/common_widgets/common_rounded_button.dart';
import 'package:recharge_buddy/core/routes/app_routes.dart';
import 'package:recharge_buddy/core/utils/constants.dart';
import 'package:recharge_buddy/core/utils/utilities.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';
import '../../../beneficiaries/presentation/screens/beneficiaries_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (context, state) {
          return CommonRoundedButton(
            text: 'Add New Beneficiary',
            onPressed: () {
              if ((state.beneficiaryList ?? []).length ==
                  kMaxBeneficiaries)
                {
                  Utils.toast("You cannot add more than 5 beneficiaries");
                  return;
                }
                AppRouter.push(AppRouter.beneficiaryFormRoute);
            },
            icon: const Icon(Icons.add, color: Colors.white),
          );
        },
      ),
      body: const Column(
        children: [BeneficiariesScreen()],
      ),
    );
  }
}
