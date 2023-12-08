import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:timetable/moudle_events/event_edit/view.dart';
import 'package:timetable/moudle_events/logic.dart';

import 'logic.dart';

class EventDetailPage extends StatelessWidget {
  EventDetailPage({Key? key}) : super(key: key);

  final logic = Get.put(EventDetailLogic());
  final state = Get.find<EventDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: EdgeInsets.only(top: Get.mediaQuery.padding.top, left: 16, right: 16),
        child: DetailPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EventEditPage());
        },
        child: const Icon(Icons.edit),
        backgroundColor: Get.theme.primaryColor,
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({super.key});

  var showModel = Get.find<EventDetailLogic>().state.eventModel;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: Get.height - Get.mediaQuery.padding.top,
            width: Get.width - 32,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Get.find<ModuleEventsLogic>().buildImportanceIcon(showModel.importance),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      showModel.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Get.find<ModuleEventsLogic>().buildDurationType(showModel.type),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      Get.find<ModuleEventsLogic>().calculateTime(showModel.startTime, showModel.endTime),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: showModel.content));
                      HapticFeedback.mediumImpact();
                    },
                    child: Container(
                      width: Get.width - 32,
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
                      decoration: BoxDecoration(
                        //根据theme
                        color: Get.theme.cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AutoSizeText(showModel.content),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
