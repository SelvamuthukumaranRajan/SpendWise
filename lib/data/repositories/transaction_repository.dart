import 'package:realm/realm.dart';
import 'package:spend_wise/data/models/user_model.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  final Realm _realm;

  TransactionRepository()
      : _realm = Realm(Configuration.local([TransactionModel.schema, UserModel.schema]));

  double calculateTotal(bool isExpense) {
    final transactions = _realm
        .all<TransactionModel>()
        .where((transaction) => transaction.isExpense == isExpense);
    return transactions.fold(0, (sum, transaction) => sum + transaction.amount);
  }

  List<TransactionModel> getAllTransactions() {
    return _realm.all<TransactionModel>().toList();
  }

  void addTransaction(TransactionModel transaction) {
    _realm.write(() {
      _realm.add(transaction);
    });
  }

  void updateTransaction(TransactionModel transaction) {
    _realm.write(() {
      _realm.add(transaction, update: true);
    });
  }

  void deleteTransaction(int id) {
    final transaction = _realm.find<TransactionModel>(id);
    if (transaction != null) {
      _realm.write(() {
        _realm.delete(transaction);
      });
    }
  }

  int getNextId() {
    final allTransactions = _realm.all<TransactionModel>();
    if (allTransactions.isEmpty) {
      return 1;
    }
    final maxId =
        allTransactions.map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  List<TransactionModel> filterTransactions({
    String? type,
    String? category,
    String? period,
  }) {
    final now = DateTime.now();
    DateTime? startDate;
    DateTime? endDate;

    if (period != null) {
      if (period == "Weekly") {
        startDate = now.subtract(Duration(days: now.weekday - 1));
        endDate = startDate.add(const Duration(days: 6));
      } else if (period == "Monthly") {
        startDate = DateTime(now.year, now.month, 1);
        endDate = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(days: 1));
      }
    }

    Iterable<TransactionModel> transactions = _realm.all<TransactionModel>();

    if (type != null) {
      final bool isExpense = type == "Expense";
      transactions = transactions.where((t) => t.isExpense == isExpense);
    }

    if (category != null) {
      transactions = transactions.where((t) => t.category == category);
    }

    if (startDate != null && endDate != null) {
      transactions = transactions.where(
        (t) => t.date.isAfter(startDate!) && t.date.isBefore(endDate!),
      );
    }

    return transactions.toList();
  }

  void login(UserModel user) {
    _realm.write(() {
      _realm.add(user);
    });
  }

  void logout(String email) {
    final user = _realm.find<UserModel>(email);
    if (user != null) {
      _realm.write(() {
        _realm.delete(user);
      });
    }
  }

  bool isUserLoggedIn() {
    return _realm.all<UserModel>().toList().isNotEmpty;
  }

  void close() {
    _realm.close();
  }
}
