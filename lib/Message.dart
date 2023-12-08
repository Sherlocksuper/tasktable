import 'package:get/get.dart';
import 'package:timetable/config.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'hello': '你好 世界',
          'title': '标题',
          'Dark Mode': '暗黑模式',
          'Sound': '声音',
          'Vibration': '震动',
          'Pop-up': '弹窗',
          'Language': '语言',
          'Remind': '提醒',
          Duration.YEAR.name: '年事件',
          Duration.MONTH.name: '月事件',
          Duration.WEEK.name: '周事件',
          Duration.DAY.name: '日事件',
          ImportantLevel.LOW.name: '低',
          ImportantLevel.MIDDLE.name: '中',
          ImportantLevel.HIGH.name: '高',
          'Add': '添加',
          'Edit': '编辑',
          'Delete': '删除',
          'Cancel': '取消',
          'Confirm': '确认',
          "Event": "事件",
          "Title": "概要",
          "Content": "内容",
          "Importance": "重要程度",
          "Type": "事件类型",
          "Start Time": "开始时间",
          "End Time": "结束时间",
          "Today's Tasks": "今日任务",
          "Appointment Reminders": "预约提醒",
        },
      };
}
