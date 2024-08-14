import 'package:flutter/material.dart';
import '../data/models/transaction_model.dart';
import '../data/models/user_model.dart';
import '../data/repositories/transaction_repository.dart';
import '../utils/routes/routes_names.dart';

enum Status { loading, success, error }

class HomeViewModel with ChangeNotifier {
  Status status = Status.loading;
  final TransactionRepository _transactionRepository;

  List<TransactionModel> _transaction = [];
  double _totalIncome = 0;
  double _totalExpense = 0;

  List<TransactionModel> get transaction => _transaction;

  String get totalIncome => _totalIncome.toString();

  String get totalExpense => _totalExpense.toString();

  HomeViewModel(this._transactionRepository);

  late UserModel _userDetails;
  String _userName = "";

  String get userName => _userName;

  String _balance = "";

  String get balance => _balance;

  String getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour >= 0 && hour < 12) {
      return 'Good morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }

  Future<void> fetchTransactions() async {
    _userDetails = _transactionRepository.getUserDetails();
    _userName = _userDetails.name;
    _balance = _userDetails.amount.toString();

    _transaction = _transactionRepository.getAllTransactions();
    _totalExpense = _transactionRepository.calculateTotal(true);
    _totalIncome = _transactionRepository.calculateTotal(false);

    status = Status.success;
    notifyListeners();
  }

  Future<void> addTransaction(String title, String desc, String category,
      String amount, bool isExpense) async {
    final transaction = TransactionModel(
      _transactionRepository.getNextId(),
      double.parse(amount),
      title,
      desc,
      category,
      isExpense,
      DateTime.now(),
    );
    _transactionRepository.addTransaction(transaction);
    updateUserBalance(isExpense, double.parse(amount));
    fetchTransactions();
  }

  Future<void> updateTransaction(
      int id,
      String title,
      String desc,
      String category,
      String amount,
      bool isExpense,
      double oldTransactionAmount,
      bool isOldTransactionAnExpense) async {
    revertUserBalance(isOldTransactionAnExpense, oldTransactionAmount);

    final updatedTransaction = TransactionModel(
      id,
      double.parse(amount),
      title,
      desc,
      category,
      isExpense,
      DateTime.now(),
    );
    _transactionRepository.updateTransaction(updatedTransaction);

    updateUserBalance(isExpense, double.parse(amount));

    fetchTransactions();
  }

  Future<void> deleteTransaction(int id, bool isExpense, String amount) async {
    _transactionRepository.deleteTransaction(id);
    revertUserBalance(isExpense, double.parse(amount));
    fetchTransactions();
  }

  void updateUserBalance(bool isExpense, double amount) {
    _transactionRepository.updateBalance(
      _userDetails.email,
      isExpense ? _userDetails.amount - amount : _userDetails.amount + amount,
    );
  }

  void revertUserBalance(bool isExpense, double amount) {
    _transactionRepository.updateBalance(
      _userDetails.email,
      isExpense ? _userDetails.amount + amount : _userDetails.amount - amount,
    );
  }

  void logoutUser(BuildContext context) {
    _transactionRepository.logout();
    Navigator.pushNamed(context, RouteNames.authScreen);
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
