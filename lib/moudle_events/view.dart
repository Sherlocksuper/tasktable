import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timetable/logic.dart';
import 'package:timetable/moudle_events/event_edit/view.dart';
import 'package:timetable/moudle_events/state.dart';
import 'logic.dart';

class ModuleEventsPage extends StatelessWidget {
  ModuleEventsPage({Key? key}) : super(key: key);

  final logic = Get.put(ModuleEventsLogic());
  final state = Get.find<ModuleEventsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ModuleEventsLogic>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 20, left: 15, right: 15),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
                    child: Text(
                      'Appointment Reminders'.tr,
                      style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Divider(),
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    return EventItem(
                      eventModel: state.eventList[index] as EventModel,
                    );
                  },
                  itemCount: state.eventList.length,
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => EventEditPage(), arguments: ["LONG-TERM"]);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final EventModel eventModel;

  const EventItem({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.dialog(EventDialog(eventItem: eventModel));
        // Get.find<ModuleEventsLogic>().showNotificationWithActions();
        Get.find<MainLogic>().showZoneSchedule();
      },
      onLongPress: () {},
      child: GetBuilder<ModuleEventsLogic>(
        builder: (controller) {
          return Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
            decoration: BoxDecoration(
              //根据theme
              color: Get.theme.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Get.find<ModuleEventsLogic>().buildImportanceIcon(eventModel.importance),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: AutoSizeText(
                    eventModel.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AutoSizeText(
                  Get.find<ModuleEventsLogic>().calculateTime(eventModel.startTime, eventModel.endTime),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EventDialog extends StatelessWidget {
  final EventModel eventItem;

  EventDialog({super.key, required this.eventItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eventItem.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              eventItem.isDone ? "已完成" : "未完成",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "开始于：${eventItem.startTime.year}年 ${eventItem.startTime.month}月${eventItem.startTime.day}日",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "结束于：${eventItem.endTime.year}年 ${eventItem.endTime.month}月${eventItem.endTime.day}日",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              eventItem.content,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
