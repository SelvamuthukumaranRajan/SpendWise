import 'package:flutter/material.dart';
import 'package:spend_wise/data/models/auth_user_model.dart';
import 'package:spend_wise/data/repositories/transaction_repository.dart';
import 'package:spend_wise/utils/auth_helper.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';

import '../data/models/user_model.dart';
import '../utils/routes/routes_names.dart';

class AuthSignupSheet extends StatefulWidget {
  final ThemeData theme;

  const AuthSignupSheet({super.key, required this.theme});

  @override
  State<AuthSignupSheet> createState() => _AuthSignupSheetState();
}

class _AuthSignupSheetState extends State<AuthSignupSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _amountController = TextEditingController();
  final authHelper = AuthHelper();

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
                  'Signup',
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
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
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
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Balance',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current balance';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                MaterialButton(
                  splashColor: Colors.transparent,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final user =
                          await authHelper.registerWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                      if (user != null) {
                        authHelper.createUser(AuthUserModel(
                            uid: user.uid,
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            balance: double.parse(_amountController.text)));
                        TransactionRepository().login(UserModel(
                            _emailController.text,
                            _nameController.text,
                            double.parse(_amountController.text)));
                        if (mounted) {
                          Navigator.pop(context, true);
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
                      'Signup',
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
