import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recharge_buddy/core/common_widgets/common_rounded_button.dart';
import 'package:recharge_buddy/core/theme/app_colors.dart';
import 'package:recharge_buddy/core/utils/constants.dart';
import 'package:recharge_buddy/core/utils/utilities.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/cubit/beneficiary_cubit.dart';
import 'package:recharge_buddy/features/beneficiaries/presentation/screens/widgets/top_up_widget.dart';

import '../../../../../core/common_widgets/common_dropdown_field.dart';
import '../../../../../core/common_widgets/common_text_field.dart';
import '../../../../../core/theme/typography.dart';
import '../../../data/model/beneficiary_model.dart';

//Creating stateful here, because we have to dispose the controllers.
class BeneficiaryForm extends StatefulWidget {
  final BeneficiaryModel? beneficiaryModel;
  const BeneficiaryForm({super.key, this.beneficiaryModel});

  @override
  _BeneficiaryFormState createState() => _BeneficiaryFormState();
}

class _BeneficiaryFormState extends State<BeneficiaryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedCountryCode;
  num _topUpValue = 0;
  bool _isEditable = true;
  String _id = '';
  bool isTopUpSelected = false;

  loadBeneficiaryValues() {
    ///Hardcoded this country code here, because the requirement
    ///is for UAE phone numbers only. Comment the line below to make it work for other countries
    _selectedCountryCode = kUaeCountryCode;
    if (widget.beneficiaryModel != null) {
      _isEditable = false;
      _id = widget.beneficiaryModel?.id ?? "";
      _nameController.text = widget.beneficiaryModel?.name ?? "";
      _phoneNumberController.text = widget.beneficiaryModel?.phoneNumber ?? "";
      _selectedCountryCode = widget.beneficiaryModel?.countryCode;
    } else {
      _id = Utils.generateUUID();
    }
  }

  @override
  void initState() {
    loadBeneficiaryValues();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BeneficiaryCubit>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
          color: AppColors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _isEditable ? "Add New Beneficiary" : "Recharge Beneficiary",
                  style: bodyLargePrimary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonTextFieldWidget(
                  controller: _nameController,
                  readOnly: !_isEditable,
                  maxLength: 20,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    if (value.length > 20) {
                      return 'Name cannot be more than 20 characters';
                    }
                    return null;
                  },
                  labelText: 'Nickname',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: AbsorbPointer(
                      absorbing: true,
                      child: CommonDropDownField(
                        onChanged: (val) {
                          _selectedCountryCode = val;
                        },
                        selectedValue: _selectedCountryCode,
                        itemsList: kCountryCodes,
                        labelText: "Code",
                      ),
                    )),
                    const SizedBox(
                        width:
                            8), // Add some space between the dropdown and text field
                    Expanded(
                      flex: 3,
                      child: CommonTextFieldWidget(
                        readOnly: !_isEditable,
                        controller: _phoneNumberController,
                        labelText: 'Phone Number',
                        maxLength: kUaeCountryCodeLength,
                        textInputType: TextInputType.phone,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          } else if (value.length != kUaeCountryCodeLength) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (!_isEditable)
                Column(
                  children: [
                    const Divider(
                      color: AppColors.gray,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Current Balance :',
                          style: bodySmall,
                        ),
                        Text(
                          '$kCurrency ${widget.beneficiaryModel?.currentBalance.toStringAsFixed(2)}',
                          style: bodySmallBold,
                        ),
                      ],
                    )
                  ],
                ),
              const Divider(
                color: AppColors.gray,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Choose Top-up Amount",
                  style: bodyLargePrimary,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: TopUpWidget(
                    topUpValue: _topUpValue,
                    onChanged: (val) {
                      _topUpValue = val;
                      isTopUpSelected = true;
                    },
                  )),
              const Spacer(),
              Center(
                child: CommonRoundedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      BeneficiaryModel model = BeneficiaryModel(
                          id: _id,
                          currentBalance: _topUpValue +
                              (widget.beneficiaryModel?.currentBalance ?? 0),
                          name: _nameController.text,
                          countryCode: _selectedCountryCode ?? "",
                          phoneNumber: _phoneNumberController.text);

                      if (!_isEditable) {
                        cubit.topUpBeneficiary(
                            model: model,
                            topUpValue: _topUpValue,
                            isTopUpSelected: isTopUpSelected);
                      } else {
                        cubit.addSingleBeneficiary(
                            model: model, isTopUpSelected: isTopUpSelected);
                      }
                    }
                  },
                  text: 'Save Changes',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
