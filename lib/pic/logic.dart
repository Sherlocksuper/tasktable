import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timetable/logic.dart';
import 'package:timetable/moudle_events/logic.dart';
import 'package:timetable/moudle_me/logic.dart';
import 'package:timetable/moudle_today/logic.dart';
import 'state.dart';

class PicLogic extends GetxController {
  final PicState state = PicState();

  //在这里放所有的logic
  @override
  Future<void> onInit() async {
    final mainLogic = Get.put(MainLogic());
    Get.put(ModuleEventsLogic());
    Get.put(ModuleCalendarLogic());
    Get.put(ModuleMeLogic());

    mainLogic.state.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    mainLogic.state.initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings =
        InitializationSettings(android: mainLogic.state.initializationSettingsAndroid);

    await mainLogic.state.flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: mainLogic.onDidReceiveNotificationResponse);

    super.onInit();
  }
}
