import 'package:get/get.dart';
import 'package:timetable/moudle_event/state.dart';
import 'package:timetable/moudle_event/view_base.dart';

import 'logic.dart';

class ModuleTodayPage extends EventListBasePage {
  ModuleTodayPage({super.key});

  final logic = Get.find<ModuleEventLogic>();
  final state = Get.find<ModuleEventLogic>().state;

  @override
  List<EventModel> getEventList() {
    return state.todayEventList;
  }

  @override
  // TODO: implement title
  get title => "今日任务";
}
