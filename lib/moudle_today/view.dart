import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable/moudle_events/event_edit/view.dart';
import 'package:timetable/moudle_events/state.dart';
import 'package:timetable/moudle_events/view.dart';

import 'logic.dart';

class ModuleCalendarPage extends StatelessWidget {
  ModuleCalendarPage({Key? key}) : super(key: key);

  final logic = Get.put(ModuleCalendarLogic());
  final state = Get.find<ModuleCalendarLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EventEditPage(), arguments: ["TODAY"]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20, left: 15, right: 15),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Text(
              "Today's Tasks".tr,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Divider(),
                ...List.generate(10, (index) => EventItem(eventModel: EventModel())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
