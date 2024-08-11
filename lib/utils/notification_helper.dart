import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as timezone;
import 'package:timezone/data/latest.dart' as timezone;

class NotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationHelper(this.flutterLocalNotificationsPlugin);

  Future<void> requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> requestIOSPermissions() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    print('Notification permissions granted: $granted');
  }

  Future<void> scheduleDailyReminderNotification() async {
    timezone.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Record your expenses',
      'Don\'t forget to record your expenses today!',
      _nextInstanceOfTime(00, 38), // Set the reminder for 8:00 PM
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_reminder_channel',
          'Daily Reminder',
          channelDescription: 'Daily reminder to record your expenses',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      // androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  timezone.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final timezone.TZDateTime now = timezone.TZDateTime.now(timezone.local);
    print("Time now : - ${now.toString()}");
    timezone.TZDateTime scheduledDate = timezone.TZDateTime(
        timezone.local, now.year, now.month, now.day, hour, minute);
    print("Time schedule : - ${scheduledDate.toString()}");

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
