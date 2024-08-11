import 'package:flutter/material.dart';
import 'package:spend_wise/viewModels/home_view_model.dart';
import '../utils/routes/routes_names.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    // final user = await userViewModel.getUser();
    // if (user!.token.toString() == "null" || user.token.toString() == "") {
    if (true) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.authScreen);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.homeScreen);
    }
  }
}
