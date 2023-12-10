import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable/Config/Message.dart';
import 'package:timetable/event_edit/view.dart';
import 'package:timetable/moudle_event/view_events.dart';
import 'package:timetable/moudle_event/view_today.dart';
import 'package:timetable/moudle_me/view.dart';
import 'package:timetable/pic/view.dart';

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
  const MyHomePage({super.key});

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
            ModuleTodayPage(),
            ModuleEventsPage(),
            ModuleMePage(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => EventEditPage());
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
