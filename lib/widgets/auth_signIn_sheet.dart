import 'package:flutter/material.dart';
import 'package:spend_wise/data/models/auth_user_model.dart';
import 'package:spend_wise/utils/auth_helper.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

import '../data/models/user_model.dart';
import '../data/repositories/transaction_repository.dart';

class AuthSignInSheet extends StatefulWidget {
  final ThemeData theme;

  const AuthSignInSheet({super.key, required this.theme});

  @override
  State<AuthSignInSheet> createState() => _AuthSignInSheetState();
}

class _AuthSignInSheetState extends State<AuthSignInSheet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.bgColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login',
                  style:
                      widget.theme.textTheme.transactionSheetLabelBold.copyWith(
                    color: widget.theme.colorScheme.textColor(),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close_rounded,
                      color: widget.theme.colorScheme.textColor(), size: 24),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 32.0),
                MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final authHelper = AuthHelper();
                      final user = await authHelper.signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text);

                      if (user != null) {
                        final userModel =
                            await authHelper.getUserDetails(user.uid);
                        if (userModel != null) {
                          TransactionRepository().login(UserModel(
                              userModel.email,
                              userModel.name,
                              userModel.balance));

                          if (mounted) {
                            Navigator.pop(context, true);
                          }
                        } else {
                          if (mounted) {
                            Navigator.pop(context, false);
                          }
                        }
                      } else {
                        if (mounted) {
                          Navigator.pop(context, false);
                        }
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.theme.colorScheme.secondaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 48),
                    child: Text(
                      'Login',
                      style: widget.theme.textTheme.statsLabelBold.copyWith(
                        color: widget.theme.colorScheme.textColor(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
