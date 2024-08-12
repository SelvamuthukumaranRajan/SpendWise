class AuthUserModel {
  final String uid;
  final String name;
  final String email;
  final String password;
  final double balance;

  AuthUserModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.balance});
}
