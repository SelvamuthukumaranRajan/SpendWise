import 'package:flutter/material.dart';
import 'package:spend_wise/data/repositories/transaction_repository.dart';
import '../utils/routes/routes_names.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) {
    if (TransactionRepository().isUserLoggedIn()) {
      Navigator.pushNamed(context, RouteNames.homeScreen);
    } else {
      Navigator.pushNamed(context, RouteNames.authScreen);
    }
  }
}
