import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recharge_buddy/core/theme/app_colors.dart';
import 'package:recharge_buddy/core/utils/constants.dart';

class TopUpWidget extends StatefulWidget {
  num topUpValue;
  final ValueChanged<num>? onChanged;

  TopUpWidget({
    Key? key,
    required this.topUpValue,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TopUpWidget> createState() => _TopUpWidgetState();
}

class _TopUpWidgetState extends State<TopUpWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 2.0,
      ),
      itemCount: kTopUpOptions.length,
      itemBuilder: (context, index) {
        final price = kTopUpOptions[index];
        bool isSelected = widget.topUpValue == price;
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.topUpValue = price;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(price);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.gray,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              '$kCurrency $price',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

