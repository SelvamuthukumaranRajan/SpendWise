import 'package:flutter/material.dart';

import '../data/models/transaction_model.dart';
import '../data/repositories/transaction_repository.dart';

class HomeViewModel with ChangeNotifier {
  int status = 3;
  final TransactionRepository _transactionRepository;

  List<TransactionModel> _transaction = [];
  double _totalIncome = 0;
  double _totalExpense = 0;

  List<TransactionModel> get transaction => _transaction;
  String get totalIncome => _totalIncome.toString();
  String get totalExpense => _totalExpense.toString();

  HomeViewModel(this._transactionRepository);


  Future<void> fetchTransactions() async {
    _transaction = _transactionRepository.getAllTransactions();
    _totalExpense = _transactionRepository.calculateTotal(true);
    _totalIncome = _transactionRepository.calculateTotal(false);
    notifyListeners();
  }

  Future<void> addTransaction(String title, String desc, String category,
      String amount, bool isExpense) async {
    final transaction = TransactionModel(_transactionRepository.getNextId(),
        double.parse(amount), title, desc, category, isExpense, DateTime.now());
    _transactionRepository.addTransaction(transaction);
    fetchTransactions();
  }

  Future<void> updateTransaction(int id, String title, String desc, String category,
      String amount, bool isExpense) async {
    final transaction = TransactionModel(id,
        double.parse(amount), title, desc, category, isExpense, DateTime.now());
    _transactionRepository.updateTransaction(transaction);
    fetchTransactions();
  }

  Future<void> deleteTransaction(int id) async {
    _transactionRepository.deleteTransaction(id);
    fetchTransactions();
  }

  @override
  void dispose() {
    _transactionRepository.close();
    super.dispose();
  }

  IconData getIcons(String category) {
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
}
