import 'package:flutter/material.dart';
import '../utils/routes/routes_names.dart';
import '../viewmodels/splash_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, RouteNames.homeScreen);
            },
            child: Center(
              child: Text(
                "Auth Screen",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      )),
    );
  }
}
