import 'package:get/get.dart';
import '../Config/config.dart';

class ModuleEventsState {
  ModuleEventsState() {
    ///Initialize variables
  }

  List<EventModel> eventList = [
    EventModel(),
    EventModel(),
    EventModel(),
    EventModel(),
    EventModel(),
    EventModel(),
  ];
}

class EventModel {
  //标题和描述(内容部分)
  String title = "Title".tr;
  String content = "默认描述";

  //重要程度
  // 0: 无 1: 低 2: 中 3: 高
  var importance = ImportantLevel.LOW;

  //事件时间和结束时间
  DateTime startTime = DateTime(2023, 12, 7);
  DateTime endTime = DateTime(2023, 12, 8);

  //已完成,用于认为标注
  bool isDone = false;
}
