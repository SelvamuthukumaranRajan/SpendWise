import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

class TransactionSwitch extends StatefulWidget {
  final ThemeData theme;
  final bool isExpense;
  final ValueChanged<bool> onChanged;

  const TransactionSwitch({super.key, required this.theme, required this.isExpense, required this.onChanged});

  @override
  TransactionSwitchState createState() => TransactionSwitchState();
}

class TransactionSwitchState extends State<TransactionSwitch>
    with SingleTickerProviderStateMixin {
  bool isSwitchedOn = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = _animationController.drive(CurveTween(curve: Curves.easeInOut));

    // Set the initial position of the switch based on isSwitchedOn
    if (widget.isExpense) {
      _animationController.forward();
    }
  }

  void toggleSwitch() {
    bool newValue = !widget.isExpense;
    widget.onChanged(newValue); // Call the callback function

    if (newValue) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }


  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tooltip(
          message: widget.isExpense ? 'Income' : 'Expense',
          child: GestureDetector(
            onTap: toggleSwitch,
            child: Container(
              width: 55,
              height: 35,
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: widget.isExpense ? Colors.green : Colors.red,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: widget.isExpense
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.isExpense ? Icons.attach_money : Icons.money_off,
                        color: widget.isExpense ? Colors.green : Colors.red,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            widget.isExpense ? 'Income' : 'Expense',
            key: ValueKey<bool>(widget.isExpense),
            style: widget.theme.textTheme.transactionSheetLabel.copyWith(
              color: widget.isExpense
                  ? widget.theme.colorScheme.incomeColor
                  : widget.theme.colorScheme.expenseColor,
            ),
          ),
        ),
      ],
    );
  }
}
