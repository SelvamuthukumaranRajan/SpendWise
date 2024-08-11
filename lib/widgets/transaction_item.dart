import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

class TransactionItem extends StatelessWidget {
  final ThemeData theme;
  final IconData icon;
  final String title, subtitle, amount;
  final bool isExpense;

  const TransactionItem(
      {super.key,
      required this.theme,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.isExpense});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.bgColor(),
          child: Icon(icon, color: theme.colorScheme.textColor()),
        ),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: theme.textTheme.transactionTitle.copyWith(
            color: theme.colorScheme.textColor(),
          ),
        ),
        subtitle: Text(
          subtitle,
          textAlign: TextAlign.start,
          style: theme.textTheme.transactionDesc.copyWith(
            color: theme.colorScheme.textColor(),
          ),
        ),
        trailing: Text(
          amount,
          style: theme.textTheme.transactionPriceLabel.copyWith(
            color: isExpense ? theme.colorScheme.expenseColor : theme.colorScheme.incomeColor,
          ),
        ),
      ),
    );
  }
}
