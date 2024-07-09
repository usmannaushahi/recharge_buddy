import 'package:flutter/material.dart';


///Common dropdown that can be used throughout the app
class CommonDropDownField extends StatelessWidget {
  String? selectedValue;
  final List<String> itemsList;
  final String labelText;
  final ValueChanged<String?>? onChanged;

  CommonDropDownField({
    super.key,
    required this.selectedValue,
    required this.itemsList,
    required this.labelText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      items: itemsList.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a country code';
        }
        return null;
      },
    );
  }
}
