import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timetable/state.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class MainLogic extends GetxController {
  final MainState state = MainState();

  @override
  onInit() {
    super.onInit();

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Shanghai'));
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> showNotificationWithActions() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "123",
      '声音',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      actions: [
        AndroidNotificationAction(
          'reply',
          'Reply',
        ),
        AndroidNotificationAction(
          'forward',
          'Forward',
        ),
      ],
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().show(
      1,
      '你好，这是一个测试',
      '这是body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> showZoneSchedule() async {
    print("object111");
    await state.flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'title',
        'body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        NotificationDetails(
            android: AndroidNotificationDetails('your channel id', 'your channel name',
                importance: Importance.max,
                priority: Priority.high,
                showWhen: true,
                playSound: true,
                enableVibration: true,
                vibrationPattern: Int64List.fromList([0, 1000, 500, 1000]))),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }
}
