import 'package:realm/realm.dart';

part 'user_model.realm.dart';

@RealmModel()
class _UserModel {
  late String name;
  late String email;
  late double amount;
}
