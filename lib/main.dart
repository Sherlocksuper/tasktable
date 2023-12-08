import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timetable/Message.dart';
import 'package:timetable/moudle_events/event_edit/view.dart';
import 'package:timetable/moudle_events/logic.dart';
import 'package:timetable/moudle_events/view.dart';
import 'package:timetable/moudle_me/logic.dart';
import 'package:timetable/moudle_me/view.dart';
import 'package:timetable/moudle_today/logic.dart';
import 'package:timetable/moudle_today/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ModuleEventsLogic());
    Get.put(ModuleCalendarLogic());
    Get.put(ModuleMeLogic());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: const TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(icon: Icon(Icons.calendar_today)),
            Tab(icon: Icon(Icons.event)),
            Tab(icon: Icon(Icons.person)),
          ],
        ),
        body: TabBarView(
          children: [
            ModuleCalendarPage(),
            ModuleEventsPage(),
            ModuleMePage(),
          ],
        ),
      ),
    );
  }
}
