import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/utils/core/app_constants.dart';
import 'package:spend_wise/widgets/transaction_switch.dart';

class AddTransactionSheet extends StatefulWidget {
  final ThemeData theme;

  const AddTransactionSheet({super.key, required this.theme});

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  List<String> _categories = AppConstants.expenseCategories;
  String? _selectedCategory;
  final _categoryController = TextEditingController();
  final _amountController = TextEditingController();

  bool isIncome = false;

  void _onTransactionSwitchChanged(bool newValue) {
    setState(() {
      isIncome = newValue;
    });
    _categories = newValue
        ? AppConstants.incomeCategories
        : AppConstants.expenseCategories;
    _selectedCategory = _categories[0];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.bgColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Transaction',
                  style:
                      widget.theme.textTheme.transactionSheetLabelBold.copyWith(
                    color: widget.theme.colorScheme.textColor(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded,
                      color: widget.theme.colorScheme.textColor(), size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                      _categoryController.text = newValue;
                    });
                  },
                  items:
                      _categories.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    TransactionSwitch(
                      theme: widget.theme,
                      isExpense: isIncome,
                      onChanged: _onTransactionSwitchChanged,
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process the form data
                      Navigator.pop(context, {
                        'title': _titleController.text,
                        'description': _descController.text,
                        'category': _categoryController.text,
                        'amount': _amountController.text,
                        'isExpense': !isIncome
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.theme.colorScheme.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 48),
                    child: Text(
                      'Add',
                      style: widget.theme.textTheme.statsLabelBold.copyWith(
                        color: widget.theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
