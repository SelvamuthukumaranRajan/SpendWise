import 'package:realm/realm.dart';

part 'expense.realm.dart';

@RealmModel()
class _Expense {
  @PrimaryKey()
  late int id;

  late double amount;
  late String title;
  late String description;
  late String category;
  late DateTime date;
}