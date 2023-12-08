import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ModuleMePage extends StatelessWidget {
  ModuleMePage({Key? key}) : super(key: key);

  final logic = Get.put(ModuleMeLogic());
  final state = Get.find<ModuleMeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ModuleMeLogic>(
      builder: (controller) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 40),
                  buildSwitch('Dark Mode', state.meModel.isDarkMode, logic.changeThemeMode),
                  //是否声音
                  buildSwitch('Sound', state.meModel.isSound, logic.changeSound),
                  //是否震动
                  buildSwitch('Vibration', state.meModel.isVibrate, logic.changeVibration),
                  //是否弹窗
                  buildSwitch('Pop-up', state.meModel.isPopup, logic.changePopUp),
                  //语言
                  ListTile(
                    title: Text('Language'.tr),
                    trailing: Text(state.meModel.language),
                    onTap: () {
                      state.meModel.language == 'English'
                          ? state.meModel.language = '中文'
                          : state.meModel.language = 'English';
                      Get.updateLocale(Locale(state.meModel.language == 'English' ? 'en' : 'zh'));
                    },
                  ),
                  //分割
                  const Divider(),
                  //提前提醒时间
                  buildRemind(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

//开关
buildSwitch(String title, bool value, Function onChanged) {
  return SwitchListTile(
    title: Text(title.tr),
    value: value,
    onChanged: (value) {
      onChanged(value);
    },
  );
}

//提前提醒
buildRemind() {
  return ListTile(
    title: const Text('提前提醒'),
    //输入框输入时间
    trailing: Text(
      '${Get.find<ModuleMeLogic>().state.meModel.remindTime}分钟',
      style: const TextStyle(color: Colors.grey),
    ),
    onTap: () {
      Get.find<ModuleMeLogic>().showRemindDialog();
    },
  );
}
