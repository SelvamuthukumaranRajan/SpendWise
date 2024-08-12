import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/views/summary_screen.dart';

import '../utils/routes/routes_names.dart';
import '../viewModels/summary_view_model.dart';

class TopSpendingItem extends StatelessWidget {
  final ThemeData theme;
  final IconData icon;
  final String title;

  const TopSpendingItem({
    super.key,
    required this.theme,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("$title Tapped");
        Navigator.pushNamed(context, RouteNames.summaryScreen,
            arguments: title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.bgColor(),
              radius: 30,
              child: Icon(icon, color: theme.colorScheme.textColor(), size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.start,
              style: theme.textTheme.topSpendingTitle.copyWith(
                color: theme.colorScheme.textColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
