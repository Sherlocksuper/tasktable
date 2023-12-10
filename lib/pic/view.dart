import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable/main.dart';

import 'logic.dart';

class PicPage extends StatelessWidget {
  PicPage({Key? key}) : super(key: key);

  final logic = Get.put(PicLogic());
  final state = Get.find<PicLogic>().state;

  @override
  Widget build(BuildContext context) {
    //Timer只运行一次
    Timer(const Duration(seconds: 1), () {
      Get.offAll(() => MyHomePage());
    });
    return const Scaffold(
      body: Center(
        child: Text("醒", style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
