import 'package:shared_preferences/shared_preferences.dart';

class ModuleMeState {
  ModuleMeState() {
    ///Initialize variables
  }

  MeModel meModel = MeModel();

  String batteryLevel = 'Unknow battery level';

  late final SharedPreferences preferences;

  //提前时间列表，0、1、5、10、20、60、120、1天、2天、
  List timeList = [0, 1, 5, 10, 20, 60, 120, 1 * 24 * 60, 2 * 24 * 60];
}

class MeModel {
  bool isPopup = true;
  bool isSound = true;
  bool isVibrate = true;
  bool isDarkMode = false;

  //语言
  String language = 'English';

  //提前提醒时间
  int remindTime = 10;
}
