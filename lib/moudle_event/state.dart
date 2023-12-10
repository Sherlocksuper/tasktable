import 'package:shared_preferences/shared_preferences.dart';

import '../Config/config.dart';

class ModuleEventState {
  ModuleEventState() {
    ///Initialize variables
  }

  late final SharedPreferences preferences;

  List<EventModel> totalEventList = [];

  List<EventModel> todayEventList = [];
}

class EventModel {
  //id利用新建时间生成
  String id = "0";
  String title = "Title";
  String content = "默认描述";

  //重要程度
  // 0: 无 1: 低 2: 中 3: 高
  var importance = ImportantLevel.LOW.name;

  //事件时间和结束时间
  DateTime startTime = DateTime(2023, 12, 7);
  DateTime endTime = DateTime(2023, 12, 8);

  //已完成,用于认为标注
  bool isDone = false;

  //fromJson
  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    importance = json['importance'];
    startTime = DateTime.parse(json['startTime']);
    endTime = DateTime.parse(json['endTime']);
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['importance'] = importance;
    data['startTime'] = startTime.toString();
    data['endTime'] = endTime.toString();
    data['isDone'] = isDone;
    return data;
  }

  EventModel();
}
