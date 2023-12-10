import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Config/config.dart';
import 'state.dart';

class ModuleEventLogic extends GetxController {
  final ModuleEventState state = ModuleEventState();

  //计算时间
  String calculateTime(DateTime startTime, DateTime endTime) {
    var now = DateTime.now();
    var differenceStart = startTime.difference(now);
    var differenceEnd = startTime.difference(now);

    //如果end小于0
    if (differenceEnd.isNegative) {
      return "已过期";
    } else if (differenceStart.isNegative) {
      //还有多久结束
      var difference = differenceEnd.inDays;
      if (difference > 0) {
        return "还有$difference天结束";
      } else {
        difference = differenceEnd.inHours;
        if (difference > 0) {
          return "还有$difference小时结束";
        } else {
          difference = differenceEnd.inMinutes;
          if (difference > 0) {
            return "还有$difference分钟结束";
          } else {
            return "即将结束";
          }
        }
      }
    } else {
      //还有多久开始
      var difference = differenceStart.inDays;
      if (difference > 0) {
        return "还有${difference}天开始";
      } else {
        difference = differenceStart.inHours;
        if (difference > 0) {
          return "还有${difference}小时开始";
        } else {
          difference = differenceStart.inMinutes;
          if (difference > 0) {
            return "还有${difference}分钟开始";
          } else {
            return "即将开始";
          }
        }
      }
    }
  }

  //利用switch和case以及Importance枚举值
  //根据重要等级构建图标
  Icon buildImportanceIcon(importance) {
    switch (importance) {
      case ImportantLevel.LOW:
        //绿色
        return const Icon(Icons.circle, color: Colors.green);
      case ImportantLevel.MIDDLE:
        //黄色
        return const Icon(Icons.circle, color: Colors.yellow);
      case ImportantLevel.HIGH:
        //红色
        return const Icon(Icons.circle, color: Colors.red);
      default:
        return const Icon(Icons.circle_outlined);
    }
  }

  //读取全部事件
  getTotalList() {
    //清空
    state.totalEventList.clear();
    var eventList = state.preferences.getStringList('eventList');
    if (eventList == null) {
      eventList = [];
      state.preferences.setStringList("eventList", []);
    }
    for (var i = 0; i < eventList.length; i++) {
      var event = EventModel.fromJson(jsonDecode(eventList[i]));
      state.totalEventList.add(event);
    }
    update();
  }

  //从total读取today事件
  getTodayList() {
    state.todayEventList.clear();
    for (var element in state.totalEventList) {
      if (isTodayTasks(element)) {
        state.todayEventList.add(element);
      }
    }
    update();
  }

  //判断是否是今日任务
  bool isTodayTasks(eventModel) {
    var now = DateTime.now();

    return (eventModel.startTime.year <= now.year &&
            eventModel.startTime.month <= now.month &&
            eventModel.startTime.day <= now.day) &&
        (eventModel.endTime.year >= now.year &&
            eventModel.endTime.month >= now.month &&
            eventModel.endTime.day >= now.day);
  }

  //新建事件
  addEvent(eventModel) {
    state.totalEventList.add(eventModel);

    getTodayList();
    updatePrefData();

    update();
  }

  //删除事件
  deleteEvent(EventModel eventItem) {
    //删除id
    state.totalEventList.removeWhere((element) => element.id == eventItem.id || element.id == "0");
    getTodayList();
    updatePrefData();

    update();
  }

  //更新本地
  updatePrefData() async {
    List<String> eventList = [];

    for (var element in state.totalEventList) {
      print(element.toJson());
      eventList.add(jsonEncode(element.toJson()));
    }
    print(eventList.length);

    state.preferences.setStringList("eventList", eventList);
  }
}
