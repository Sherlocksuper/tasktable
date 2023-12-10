import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timetable/logic.dart';
import 'package:timetable/moudle_me/logic.dart';
import '../event_edit/logic.dart';
import '../moudle_event/logic.dart';
import 'state.dart';

class PicLogic extends GetxController {
  final PicState state = PicState();

  //在这里放所有的logic
  @override
  Future<void> onInit() async {
    //放入各种logic
    final mainLogic = Get.put(MainLogic());
    final eventLogic = Get.put(ModuleEventLogic());
    final meLogic = Get.put(ModuleMeLogic());

    //初始化通知plugin
    mainLogic.state.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    mainLogic.state.initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings =
        InitializationSettings(android: mainLogic.state.initializationSettingsAndroid);

    await mainLogic.state.flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: mainLogic.onDidReceiveNotificationResponse);

    //读取用户配置
    await meLogic.readUserConfig();

    //初始化事件
    eventLogic.state.preferences = await SharedPreferences.getInstance();
    await eventLogic.getTotalList();
    await eventLogic.getTodayList();

    super.onInit();
  }
}
