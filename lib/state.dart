import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MainState {
  MainState() {
    ///Initialize variables
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');

}
