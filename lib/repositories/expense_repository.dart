import 'package:realm/realm.dart';
import '../models/expense.dart';

class ExpenseRepository {
  final Realm _realm;

  ExpenseRepository() : _realm = Realm(Configuration.local([Expense.schema]));

  List<Expense> getAllExpenses() {
    return _realm.all<Expense>().toList();
  }

  void addExpense(Expense expense) {
    _realm.write(() {
      _realm.add(expense);
    });
  }

  void updateExpense(Expense expense) {
    _realm.write(() {
      _realm.add(expense, update: true);
    });
  }

  void deleteExpense(int id) {
    final expense = _realm.find<Expense>(id);
    if (expense != null) {
      _realm.write(() {
        _realm.delete(expense);
      });
    }
  }

  int getNextId() {
    final maxId = _realm.all<Expense>().map((e) => e.id).reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  void close() {
    _realm.close();
  }
}