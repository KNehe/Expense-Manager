class DateUtils {

  String getWeekDayName(int i){

    String weekDayName;

    switch(i){
      case 1: weekDayName = "Mon"; break;
      case 2 : weekDayName =  "Tues"; break;
      case 3 : weekDayName = "Wed"; break;
      case 4: weekDayName =  "Thurs"; break;
      case 5: weekDayName =  "Fri"; break;
      case 6: weekDayName =  "Sat"; break;
      case 7: weekDayName =  "Sun"; break;
    }
    return weekDayName;
  }


  int getWeekDayIntValue(String stringValue){

    int weekDayIntValue;

    switch(stringValue){
      case "Mon": weekDayIntValue = 1; break;
      case "Tues": weekDayIntValue =  2; break;
      case "Wed": weekDayIntValue = 3 ; break;
      case "Thurs": weekDayIntValue =  4; break;
      case "Fri": weekDayIntValue =  5; break;
      case "Sat": weekDayIntValue =  6; break;
      case "Sun": weekDayIntValue =  7; break;
    }
    return weekDayIntValue;
  }

}