import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable/moudle_event/state.dart';
import 'package:timetable/moudle_event/view_base.dart';

import 'logic.dart';

class ModuleEventsPage extends EventListBasePage {
  ModuleEventsPage({Key? key}) : super(key: key);

  final logic = Get.find<ModuleEventLogic>();
  final state = Get.find<ModuleEventLogic>().state;

  @override
  List<EventModel> getEventList() {
    return state.totalEventList;
  }

  @override
  // TODO: implement title
  get title => "预约提醒";
}
