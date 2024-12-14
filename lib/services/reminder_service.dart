import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../models/medicine.dart';

class ReminderService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleMedicineReminder(Medicine medicine) async {
    final List<PendingNotificationRequest> pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();

    // Cancel existing reminders for this medicine
    for (var notification in pendingNotifications) {
      if (notification.payload == medicine.id) {
        await _flutterLocalNotificationsPlugin.cancel(notification.id);
      }
    }

    // Schedule new reminders
    final now = tz.TZDateTime.now(tz.local);
    final today = tz.TZDateTime(tz.local, now.year, now.month, now.day);

    // Parse dosage frequency
    final frequency = _parseDosageFrequency(medicine.frequency);

    for (int i = 0; i < frequency.times; i++) {
      final scheduledDate = today.add(Duration(
        hours: frequency.startHour + (i * (24 / frequency.times)).round(),
      ));

      if (scheduledDate.isAfter(now)) {
        await _flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse(medicine.id) + i, // Convert string ID to int for notification ID
          'Medicine Reminder',
          'Time to take ${medicine.name}',
          scheduledDate,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'medicine_reminders',
              'Medicine Reminders',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails(),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: medicine.id,
        );
      }
    }
  }

  DosageFrequency _parseDosageFrequency(String frequency) {
    // This is a simplified parser. You may need to implement a more sophisticated one
    // based on your specific frequency format.
    if (frequency.toLowerCase().contains('once a day')) {
      return DosageFrequency(times: 1, startHour: 8);
    } else if (frequency.toLowerCase().contains('twice a day')) {
      return DosageFrequency(times: 2, startHour: 8);
    } else if (frequency.toLowerCase().contains('three times a day')) {
      return DosageFrequency(times: 3, startHour: 8);
    } else {
      // Default to once a day
      return DosageFrequency(times: 1, startHour: 8);
    }
  }
}

class DosageFrequency {
  final int times;
  final int startHour;

  DosageFrequency({required this.times, required this.startHour});
}

