import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/utils/notification_helper.dart';
import 'package:spend_wise/utils/routes/routes.dart';
import 'package:spend_wise/utils/routes/routes_names.dart';
import 'package:spend_wise/viewModels/home_view_model.dart';
import 'package:spend_wise/viewModels/summary_view_model.dart';
import 'dart:io';

import 'data/repositories/transaction_repository.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Initialize notifications
    await initializeNotifications();

    // Run the app
    runApp(const MyApp());
  } catch (e) {
    print("Initialization Error: $e");
  }
}

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iOSInitializationSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {
      print("Foreground Notification Received: $title");
    },
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: iOSInitializationSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print("Notification Received: ${response.payload}");
    },
  );

  final notificationHelper =
      NotificationHelper(flutterLocalNotificationsPlugin);

  if (Platform.isAndroid) {
    await _handleAndroidNotification(notificationHelper);
  } else if (Platform.isIOS) {
    await _handleIOSNotification(notificationHelper);
  }
}

Future<void> _handleAndroidNotification(
    NotificationHelper notificationHelper) async {
  await notificationHelper.requestExactAlarmPermission();
  if (await Permission.scheduleExactAlarm.isGranted) {
    await notificationHelper.scheduleDailyReminderNotification();
  }
}

Future<void> _handleIOSNotification(
    NotificationHelper notificationHelper) async {
  await notificationHelper.requestIOSPermissions();
  await notificationHelper.scheduleDailyReminderNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(TransactionRepository()),
        ),
        ChangeNotifierProvider(
          create: (_) => SummaryViewModel(TransactionRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Spend Wise',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().buildLightTheme(),
        darkTheme: AppTheme().buildDarkTheme(),
        themeMode: ThemeMode.system,
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}
