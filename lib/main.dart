import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:spend_wise/repositories/expense_repository.dart';
import 'package:spend_wise/utils/configs/app_theme.dart';
import 'package:spend_wise/utils/notification_helper.dart';
import 'package:spend_wise/utils/routes/routes.dart';
import 'package:spend_wise/utils/routes/routes_names.dart';
import 'package:spend_wise/viewModels/home_view_model.dart';
import 'dart:io';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  initializeNotifications();
  runApp(const MyApp());
}

void initializeNotifications() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsIOS =
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
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      print("Notification Received: ${response.payload}");
    },
  );

  // Schedule the daily reminder notification
  final notificationHelper =
      NotificationHelper(flutterLocalNotificationsPlugin);

  if (Platform.isAndroid) {
    notificationHelper.requestExactAlarmPermission();
    if (await Permission.scheduleExactAlarm.isGranted) {
      await notificationHelper.scheduleDailyReminderNotification();
    }
  } else if (Platform.isIOS) {
    notificationHelper.requestIOSPermissions();
    await notificationHelper.scheduleDailyReminderNotification();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => HomeViewModel(ExpenseRepository()))
      ],
      child: PopScope(
        canPop: true, // Set this based on your logic
        onPopInvoked: (didPop) {
          if (didPop) {
            // Handle the pop action
            Navigator.pop(context);
          } else {
            // Handle the case where pop was blocked
          }
        },
        child: MaterialApp(
          title: 'Spend Wise',
          debugShowCheckedModeBanner: false,
          theme: AppTheme().buildLightTheme(),
          darkTheme: AppTheme().buildDarkTheme(),
          themeMode: ThemeMode.system,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: Routes.generateRoutes,
        ),
      ),
    );
  }
}
