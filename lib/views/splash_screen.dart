import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import '../viewmodels/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();

    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        SplashService.checkAuthentication(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        Lottie.asset(
          'assets/animation/splash_background.json',
          controller: _controller,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
          },
        ),
        Center(
          child: Text(
            'Spend wise',
            style: theme.textTheme.splashLabel.copyWith(
              color: theme.colorScheme.textColor(),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ])),
    );
  }
}
