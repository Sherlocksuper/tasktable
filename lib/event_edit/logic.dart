import 'package:get/get.dart';
import 'package:timetable/moudle_event/logic.dart';
import '../moudle_event/state.dart';
import 'state.dart';

class EventEditLogic extends GetxController {
  final EventEditState state = EventEditState();

  @override
  void onInit() {
    super.onInit();
    state.eventModel = EventModel();
    state.eventModel.startTime = DateTime.now();
    state.eventModel.endTime = DateTime.now();

    state.eventModel.id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  //写入事件
  void writeEvent() {
    EventModel eventModel = state.eventModel;
    Get.find<ModuleEventLogic>().addEvent(eventModel);
    Get.back();
  }
}
