import 'package:realm/realm.dart';

part 'transaction_model.realm.dart';

@RealmModel()
class _TransactionModel {
  @PrimaryKey()
  late int id;

  late double amount;
  late String title;
  late String description;
  late String category;
  late bool isExpense;
  late DateTime date;
}
