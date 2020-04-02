import 'package:expensetracker/Utilities/dateUtils.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  group('GetWeekDayName tests', (){

    test('Should return Monday',(){
      String result = DateUtils().getWeekDayName(1);
      expect(result, 'Mon');
    });

    test('Should return Tuesday',(){
      String result = DateUtils().getWeekDayName(2);
      expect(result, 'Tues');
    });

    test('Should return Wednesday',(){
      String result = DateUtils().getWeekDayName(3);
      expect(result, 'Wed');
    });

    test('Should return Thursday',(){
      String result = DateUtils().getWeekDayName(4);
      expect(result, 'Thurs');
    });

    test('Should return Friday',(){
      String result = DateUtils().getWeekDayName(5);
      expect(result, 'Fri');
    });

    test('Should return Saturday',(){
      String result = DateUtils().getWeekDayName(6);
      expect(result, 'Sat');
    });

    test('Should return Sunday',(){
      String result = DateUtils().getWeekDayName(7);
      expect(result, 'Sun');
    });

  });

  group('GetWeekDayIntValue tests', (){

    test('Should return 1 when day is Monday',(){
      int result = DateUtils().getWeekDayIntValue('Mon');
      expect(result, 1);
    });

    test('Should return 2 when day is Tuesday',(){
      int result = DateUtils().getWeekDayIntValue('Tues');
      expect(result, 2);
    });

    test('Should return 3 when day is Wednesday',(){
      int result = DateUtils().getWeekDayIntValue('Wed');
      expect(result, 3);
    });

    test('Should return 4 when day is Thursday',(){
      int result = DateUtils().getWeekDayIntValue('Thurs');
      expect(result, 4);
    });

    test('Should return 5 when day is  Friday',(){
      int result = DateUtils().getWeekDayIntValue('Fri');
      expect(result, 5);
    });

    test('Should return 6 when day is Saturday',(){
      int result = DateUtils().getWeekDayIntValue('Sat');
      expect(result, 6);
    });

    test('Should return 7 when day is Sunday',(){
      int result = DateUtils().getWeekDayIntValue('Sun');
      expect(result, 7);
    });

  });

  }
