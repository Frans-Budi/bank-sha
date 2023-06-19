import 'package:bank_sha/models/data_plan_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class PackageItem extends StatelessWidget {
  final DataPlanModel dataPlan;
  final bool isSelected;

  const PackageItem({
    super.key,
    required this.dataPlan,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      height: 170,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppTheme.blueColor : AppTheme.whiteColor,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Amount Kuota
          Text(
            dataPlan.name.toString(),
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 32, fontWeight: AppTheme.medium),
          ),
          const SizedBox(height: 2),
          Text(
            formatCurreny(dataPlan.price ?? 0),
            style: AppTheme.greyTextStyle.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
