import 'package:realm/realm.dart';

part 'user_model.realm.dart';

@RealmModel()
class _UserModel {
  @PrimaryKey()
  late String email;
  late String name;
  late double amount;
}
