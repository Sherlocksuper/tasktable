import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'logic.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class EventEditPage extends StatelessWidget {
  EventEditPage({Key? key}) : super(key: key);

  final logic = Get.put(EventEditLogic());
  final state = Get.find<EventEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<EventEditLogic>(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(top: Get.mediaQuery.padding.top, left: 16, right: 16),
            child: EditPage(),
          );
        },
      ),
    );
  }
}

class EditPage extends StatelessWidget {
  EditPage({super.key});

  final logic = Get.find<EventEditLogic>();
  final state = Get.find<EventEditLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: state.eventModel.title.tr,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            state.eventModel.title = value;
          },
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          maxLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(20)],
        ),
        const Gap(20),
        GestureDetector(
          onTap: () async {
            List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
              context: context,
              startInitialDate: DateTime.now(),
              startFirstDate: DateTime(1600).subtract(const Duration(days: 1800)),
              startLastDate: DateTime.now().add(
                const Duration(days: 7304),
              ),
              endInitialDate: DateTime.now(),
              endFirstDate: DateTime(1600).subtract(const Duration(days: 1800)),
              endLastDate: DateTime.now().add(
                const Duration(days: 7304),
              ),
              is24HourMode: true,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              constraints: const BoxConstraints(
                maxWidth: 350,
                maxHeight: 650,
              ),
              transitionBuilder: (context, anim1, anim2, child) {
                return FadeTransition(
                  opacity: anim1.drive(
                    Tween(
                      begin: 0,
                      end: 1,
                    ),
                  ),
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 200),
              barrierDismissible: true,
              selectableDayPredicate: (dateTime) {
                // Disable 25th Feb 2023
                if (dateTime == DateTime(2023, 2, 25)) {
                  return false;
                } else {
                  return true;
                }
              },
            );
            state.eventModel.startTime = dateTimeList![0];
            state.eventModel.endTime = dateTimeList[1];
            logic.update();
          },
          child: Row(
            children: [
              Expanded(
                child: AutoSizeText(
                  "${state.eventModel.startTime.year}-${state.eventModel.startTime.month}-${state.eventModel.startTime.day}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: AutoSizeText(
                  "${state.eventModel.endTime.year}-${state.eventModel.endTime.month}-${state.eventModel.endTime.day}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Gap(20),
        TextField(
          decoration: InputDecoration(
            hintText: state.eventModel.content.tr,
            border: InputBorder.none,
          ),
          onChanged: (value) {
            state.eventModel.content = value;
          },
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          maxLines: 1,
          inputFormatters: [LengthLimitingTextInputFormatter(20)],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            logic.writeEvent();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            shape: const StadiumBorder(),
          ),
          child: SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: Text(
                "保存".tr,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        const Gap(40),
      ],
    );
  }
}
