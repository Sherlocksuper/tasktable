import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../moudle_event/logic.dart';
import 'state.dart';

class ModuleMeLogic extends GetxController {
  final ModuleMeState state = ModuleMeState();

  @override
  onInit() {
    super.onInit();
  }

  //以下是修改逻辑
  //更改主题
  changeThemeMode(value) {
    state.meModel.isDarkMode = value;
    Get.changeTheme(state.meModel.isDarkMode ? ThemeData.dark() : ThemeData.light());
    state.preferences.setBool('isDarkMode', state.meModel.isDarkMode);
    update();
  }

  //更改声音
  changeSound(value) {
    state.meModel.isSound = value;
    state.preferences.setBool('isSound', state.meModel.isSound);
    update();
  }

  //更改震动
  changeVibration(value) {
    state.meModel.isVibrate = value;
    state.preferences.setBool('isVibrate', state.meModel.isVibrate);
    update();
  }

  //弹窗
  changePopUp(value) {
    state.meModel.isPopup = value;
    state.preferences.setBool('isPopup', state.meModel.isPopup);
    update();
  }

  //语言
  changeLanguage(value) {
    state.meModel.language = value;
    state.preferences.setString('language', state.meModel.language);
    Get.updateLocale(Locale(state.meModel.language == 'English' ? 'en' : 'zh'));
    update();
  }

  //提前提醒
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

  //利用shared_preferences存储数据
  saveUserConfig() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool('isDarkMode', state.meModel.isDarkMode);
    preferences.setBool('isSound', state.meModel.isSound);
    preferences.setBool('isVibrate', state.meModel.isVibrate);
    preferences.setBool('isPopup', state.meModel.isPopup);
    preferences.setString('language', state.meModel.language);
    preferences.setInt('remindTime', state.meModel.remindTime);

    print('保存用户设置');
  }

  //利用shared_preferences读取用户配置
  readUserConfig() async {
    state.preferences = await SharedPreferences.getInstance();

    try {
      state.preferences.getBool('isDarkMode');
    } catch (e) {
      saveUserConfig();
    }
    state.meModel.isDarkMode = state.preferences.getBool('isDarkMode') ?? false;
    state.meModel.isSound = state.preferences.getBool('isSound') ?? false;
    state.meModel.isVibrate = state.preferences.getBool('isVibrate') ?? false;
    state.meModel.isPopup = state.preferences.getBool('isPopup') ?? false;
    state.meModel.language = state.preferences.getString('language') ?? 'English';
    state.meModel.remindTime = state.preferences.getInt('remindTime') ?? 5;

    //读取的时候如果是深色模式就改变主题
    if (state.meModel.isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }

    print('读取用户设置');
  }

  clearData() {
    //清空了本地数据
    Get.find<ModuleEventLogic>().state.preferences.clear();
    //清空当前数据
    Get.find<ModuleEventLogic>().state.totalEventList.clear();
    Get.find<ModuleEventLogic>().state.todayEventList.clear();
    update();
  }
}
