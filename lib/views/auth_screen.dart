import 'package:flutter/material.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/widgets/auth_signIn_sheet.dart';

import '../utils/routes/routes_names.dart';
import '../widgets/auth_signup_sheet.dart';

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
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.25),
              Text(
                'Spend wise',
                style: theme.textTheme.authLabelBold.copyWith(
                  color: theme.colorScheme.textColor(),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                'Turn Your Expenses into Insights!',
                style: theme.textTheme.authLabel.copyWith(
                  color: theme.colorScheme.textColor(),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: width * 0.8, // Width of the button
                height: 55, // Height of the button
                child: MaterialButton(
                  onPressed: () async {
                    final bool? isSuccess = await showModalBottomSheet<bool>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => AuthSignupSheet(
                        theme: theme,
                      ),
                    );
                    if (isSuccess == true && mounted) {
                      Navigator.pushNamed(context, RouteNames.homeScreen);
                    }
                  },
                  color: theme.colorScheme.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Signup',
                    style: theme.textTheme.authLabel.copyWith(
                      color: theme.colorScheme.textColor(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: TextButton(
                  onPressed: () async {
                    final bool? isSuccess = await showModalBottomSheet<bool>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => AuthSignInSheet(
                        theme: theme,
                      ),
                    );
                    if (isSuccess == true && mounted) {
                      Navigator.pushNamed(context, RouteNames.homeScreen);
                    }
                  },
                  child: Text(
                    'Already have an account? Log in',
                    style: theme.textTheme.authLoginLabel.copyWith(
                      color: theme.colorScheme.textColor(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
