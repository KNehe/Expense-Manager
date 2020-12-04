import 'package:expensetracker/models/range.dart';

class DateUtils {
  String getWeekDayName(int i) {
    String weekDayName;

    switch (i) {
      case 1:
        weekDayName = "Mon";
        break;
      case 2:
        weekDayName = "Tues";
        break;
      case 3:
        weekDayName = "Wed";
        break;
      case 4:
        weekDayName = "Thurs";
        break;
      case 5:
        weekDayName = "Fri";
        break;
      case 6:
        weekDayName = "Sat";
        break;
      case 7:
        weekDayName = "Sun";
        break;
    }
    return weekDayName;
  }

  int getWeekDayIntValue(String stringValue) {
    int weekDayIntValue;

    switch (stringValue) {
      case "Mon":
        weekDayIntValue = 1;
        break;
      case "Tues":
        weekDayIntValue = 2;
        break;
      case "Wed":
        weekDayIntValue = 3;
        break;
      case "Thurs":
        weekDayIntValue = 4;
        break;
      case "Fri":
        weekDayIntValue = 5;
        break;
      case "Sat":
        weekDayIntValue = 6;
        break;
      case "Sun":
        weekDayIntValue = 7;
        break;
    }
    return weekDayIntValue;
  }

  String formatIntDayValue(int day) {
    String dayValue;

    switch (day) {
      case 1:
        dayValue = '01';
        break;
      case 2:
        dayValue = '02';
        break;
      case 3:
        dayValue = '03';
        break;
      case 4:
        dayValue = '04';
        break;
      case 5:
        dayValue = '05';
        break;
      case 6:
        dayValue = '06';
        break;
      case 7:
        dayValue = '07';
        break;
      case 8:
        dayValue = '08';
        break;
      case 9:
        dayValue = '09';
        break;
      default:
        dayValue = day.toString();
    }

    return dayValue;
  }

  String formatIntMonthValue(int month) {
    String monthValue;

    switch (month) {
      case 1:
        monthValue = '01';
        break;
      case 2:
        monthValue = '02';
        break;
      case 3:
        monthValue = '03';
        break;
      case 4:
        monthValue = '04';
        break;
      case 5:
        monthValue = '05';
        break;
      case 6:
        monthValue = '06';
        break;
      case 7:
        monthValue = '07';
        break;
      case 8:
        monthValue = '08';
        break;
      case 9:
        monthValue = '09';
        break;
      default:
        monthValue = month.toString();
    }

    return monthValue;
  }

  Range getRangeFromWeekName(String weekName) {
    Range range;

    switch (weekName) {
      case 'Week 1':
        range = Range(firstDay: 1, lastDay: 7);
        break;
      case 'Week 2':
        range = Range(firstDay: 8, lastDay: 14);
        break;
      case 'Week 3':
        range = Range(firstDay: 15, lastDay: 21);
        break;
      case 'Week 4':
        range = Range(firstDay: 22, lastDay: 28);
        break;
      case '29th':
        range = Range(firstDay: 29, lastDay: 29);
        break;
      case ' 29th - 30th':
        range = Range(firstDay: 29, lastDay: 30);
        break;
      case ' 29th - 31st':
        range = Range(firstDay: 29, lastDay: 31);
        break;
    }
    return range;
  }
}
