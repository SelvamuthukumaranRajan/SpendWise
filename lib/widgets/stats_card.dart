import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

class StatsCard extends StatelessWidget {
  final ThemeData theme;
  final String balance, income, expense;

  const StatsCard({
    super.key,
    required this.theme,
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    double progress = int.parse(expense) / int.parse(balance);
    if (progress < 0) {
      progress = 0;
    } else if (progress > 1) {
      progress = 1;
    }
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryColor,
        borderRadius: BorderRadius.circular(20),
        // gradient: const LinearGradient(
        //   colors: [Colors.purpleAccent, Colors.blueAccent],
        // ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: theme.textTheme.statsLabelBold.copyWith(
              color: theme.colorScheme.textColor(),
            ),
          ),
          Text(
            '₹ $balance',
            style: theme.textTheme.statsBalanceBold.copyWith(
              color: theme.colorScheme.textColor(),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Monthly Expenses',
            style: theme.textTheme.statsLabelNormal.copyWith(
              color: theme.colorScheme.textColor(),
            ),
          ),
          const SizedBox(height: 5),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white24,
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.incomeColor),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹ $expense',
                style: theme.textTheme.statsLabelNormal.copyWith(
                  color: theme.colorScheme.textColor(),
                ),
              ),
              Text(
                '₹ $balance',
                style: theme.textTheme.statsLabelNormal.copyWith(
                  color: theme.colorScheme.textColor(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 21),
                decoration: BoxDecoration(
                  color: theme.colorScheme.bgColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(Icons.trending_up_rounded,
                          color: theme.colorScheme.incomeColor),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Income',
                          style: theme.textTheme.statsLabelNormal.copyWith(
                            color: theme.colorScheme.textColor(),
                          ),
                        ),
                        Text(
                          '₹ $income',
                          style: theme.textTheme.statsLabelNormal.copyWith(
                            color: theme.colorScheme.textColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 21),
                decoration: BoxDecoration(
                  color: theme.colorScheme.bgColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.trending_down_rounded,
                          color: theme.colorScheme.expenseColor),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expense',
                          style: theme.textTheme.statsLabelNormal.copyWith(
                            color: theme.colorScheme.textColor(),
                          ),
                        ),
                        Text(
                          '₹ $expense',
                          style: theme.textTheme.statsLabelNormal.copyWith(
                            color: theme.colorScheme.textColor(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
