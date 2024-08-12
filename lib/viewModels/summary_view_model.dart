import 'package:flutter/material.dart';

import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repository.dart';
import '../utils/core/app_constants.dart';

enum Status { loading, success, error }

class SummaryViewModel with ChangeNotifier {
  final TransactionRepository _transactionRepository;

  Status status = Status.loading;
  List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  final List<String> _types = AppConstants.transactionType;

  List<String> get types => _types;

  final List<String> _periods = AppConstants.transactionPeriod;

  List<String> get periods => _periods;

  List<String> _categories =
      AppConstants.expenseCategories + AppConstants.incomeCategories;

  List<String> get categories => _categories;

  String _selectedType = "Type";

  String get selectedType => _selectedType;

  String _selectedCategory = "Category";

  String get selectedCategory => _selectedCategory;

  String _selectedPeriod = "Periods";

  String get selectedPeriod => _selectedPeriod;

  SummaryViewModel(this._transactionRepository);

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Future<void> fetchTransactions() async {
    _transactions = _transactionRepository.getAllTransactions();
    filterTransactions(selectedCategory: _selectedCategory);
    status = Status.success;
    notifyListeners();
  }

  Future<void> filterTransactions({
    String? selectedType,
    String? selectedCategory,
    String? selectedPeriod,
  }) async {
    if (selectedType != null) {
      _selectedType = selectedType;
      _categories = selectedType == "Expense"
          ? AppConstants.expenseCategories
          : selectedType == "Income"
              ? AppConstants.incomeCategories
              : AppConstants.expenseCategories + AppConstants.incomeCategories;
    }

    if (selectedCategory != null) {
      _selectedCategory = selectedCategory;
    }

    if (selectedPeriod != null) {
      _selectedPeriod = selectedPeriod;
    }

    _transactions = _transactionRepository.filterTransactions(
      type: _selectedType == "Type" ? null : _selectedType,
      category: _selectedCategory == "Category" ? null : _selectedCategory,
      period: _selectedPeriod == "Period" ? null : _selectedPeriod,
    );
    notifyListeners();
  }

  Future<void> updateTransaction({
    required int id,
    required String title,
    required String desc,
    required String category,
    required String amount,
    required bool isExpense,
  }) async {
    final transaction = TransactionModel(
      id,
      double.parse(amount),
      title,
      desc,
      category,
      isExpense,
      DateTime.now(),
    );
    _transactionRepository.updateTransaction(transaction);
    fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    _transactionRepository.deleteTransaction(id);
    fetchTransactions();
  }

  IconData getIconForCategory(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood_rounded;
      case 'Travel':
        return Icons.flight_rounded;
      case 'Bills':
        return Icons.subscriptions_rounded;
      case 'Shopping':
        return Icons.shopping_bag;
      case 'Salary':
        return Icons.attach_money_rounded;
      case 'Business':
        return Icons.business_center_rounded;
      case 'Investments':
        return Icons.trending_up_rounded;
      case 'Interest':
        return Icons.savings_rounded;
      default:
        return Icons.category_rounded;
    }
  }

  @override
  void dispose() {
    _transactionRepository.close();
    super.dispose();
  }
}
