import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'state.dart';

class ModuleMeLogic extends GetxController {
  final ModuleMeState state = ModuleMeState();

  changeThemeMode(value) {
    state.meModel.isDarkMode = value;
    Get.changeTheme(state.meModel.isDarkMode ? ThemeData.dark() : ThemeData.light());
    update();
  }

  changeSound(value) {
    state.meModel.isSound = value;
    update();
  }

  changeVibration(value) {
    state.meModel.isVibrate = value;
    update();
  }

  changePopUp(value) {
    state.meModel.isPopup = value;
    update();
  }

  //提前提醒弹出框
  showRemindDialog() {
    Get.bottomSheet(
      Container(
        height: 300,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              title: Text('Remind'.tr),
              trailing: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: state.timeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${state.timeList[index]}分钟"),
                    onTap: () {
                      state.meModel.remindTime = state.timeList[index];
                      Get.back();
                      update();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
