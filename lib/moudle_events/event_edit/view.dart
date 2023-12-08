import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'logic.dart';

class EventEditPage extends StatelessWidget {
  EventEditPage({Key? key}) : super(key: key);

  final logic = Get.put(EventEditLogic());
  final state = Get.find<EventEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: Get.mediaQuery.padding.top, left: 16, right: 16),
        child: EditPage(),
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //标题编辑
        TextField(
          decoration: InputDecoration(
            hintText: 'Title'.tr,
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          maxLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(20)],
        ),
      ],
    );
  }
}
