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
    Timer.periodic(const Duration(seconds: 1), (timer) {
      Get.off(() => MyHomePage());
    });
    return const Scaffold(
      body: Center(
        child: Text("醒", style: TextStyle(fontSize: 30)),
      ),
    );
  }
}
