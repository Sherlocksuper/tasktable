import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timetable/Config/Message.dart';
import 'package:timetable/moudle_events/logic.dart';
import 'package:timetable/moudle_events/view.dart';
import 'package:timetable/moudle_me/logic.dart';
import 'package:timetable/moudle_me/view.dart';
import 'package:timetable/moudle_today/logic.dart';
import 'package:timetable/moudle_today/view.dart';
import 'package:timetable/pic/view.dart';

import 'logic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: PicPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
