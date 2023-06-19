import 'package:bank_sha/models/transaction_model.dart';
import 'package:bank_sha/shared/methods.dart';
import 'package:bank_sha/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLatestTransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const HomeLatestTransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Image.network(transaction.transactionType!.thumbnail!, width: 48),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.transactionType!.name.toString(),
                  style: AppTheme.blackTextStyle
                      .copyWith(fontSize: 16, fontWeight: AppTheme.medium),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('MMM dd').format(
                    transaction.createdAt ?? DateTime.now(),
                  ),
                  style: AppTheme.greyTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            formatCurreny(
              transaction.amount ?? 0,
              symbol: transaction.transactionType!.action == 'db' ? '- ' : '+ ',
            ),
            style: AppTheme.blackTextStyle
                .copyWith(fontSize: 16, fontWeight: AppTheme.medium),
          ),
        ],
      ),
    );
  }
}
