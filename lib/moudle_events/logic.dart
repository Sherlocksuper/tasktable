import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../config.dart';

import 'state.dart';

class ModuleEventsLogic extends GetxController {
  final ModuleEventsState state = ModuleEventsState();

  Future<void> showNotificationWithActions() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'hat?',
      '声音',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await FlutterLocalNotificationsPlugin().show(
      0,
      '你好，这是一个测试',
      '这是body',
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

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
        return "还有${difference}天结束";
      } else {
        difference = differenceEnd.inHours;
        if (difference > 0) {
          return "还有${difference}小时结束";
        } else {
          difference = differenceEnd.inMinutes;
          if (difference > 0) {
            return "还有${difference}分钟结束";
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

  //根据重要等级构建图标
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

  //根据事件类型构建图标
  //利用switch和case以及EventType枚举值
  Widget buildDurationType(type) {
    //根据事件类型构建颜色
    Color buildColor(type) {
      switch (type) {
        case Duration.YEAR:
          return Colors.blue;
        case Duration.MONTH:
          return Colors.green;
        case Duration.WEEK:
          return Colors.yellow;
        case Duration.DAY:
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: buildColor(type),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        type.toString().split('.')[1],
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
