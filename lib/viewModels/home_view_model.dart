import 'package:flutter/cupertino.dart';

import '../models/expense.dart';
import '../repositories/expense_repository.dart';

class HomeViewModel with ChangeNotifier {
  int status = 3;
  final ExpenseRepository _expenseRepository;

  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  HomeViewModel(this._expenseRepository);

  Future<void> fetchExpenses() async {
    _expenses = _expenseRepository.getAllExpenses();
    print("Expenses : ${_expenses.length}");
    print("Expenses : ${_expenses.toString()}");
    notifyListeners(); // Notify the UI to update
  }

  Future<void> addExpense(
      String title, String desc, String category, String amount) async {
    final transaction =
        Expense(_expenseRepository.getNextId(), double.parse(amount), title, desc, category, DateTime.now());
    _expenseRepository.addExpense(transaction);
    fetchExpenses(); // Refresh the list of expenses
  }

  Future<void> updateExpense(Expense expense) async {
    _expenseRepository.updateExpense(expense);
    fetchExpenses(); // Refresh the list of expenses
  }

  Future<void> deleteExpense(int id) async {
    _expenseRepository.deleteExpense(id);
    fetchExpenses(); // Refresh the list of expenses
  }

  @override
  void dispose() {
    _expenseRepository.close();
    super.dispose();
  }
}
