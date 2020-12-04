import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/models/income.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/models/weekExpense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  group('Expense model', () {
    Expense expense = Expense(
        barColor: charts.ColorUtil.fromDartColor(Colors.purple),
        item: 'food',
        price: 200);

    test('Expense should have all right params', () {
      expect(expense, isNotNull);

      expect(expense.price, 200);

      expect(expense.item, 'food');

      expect(expense.barColor, charts.ColorUtil.fromDartColor(Colors.purple));

      expect(expense.runtimeType, Expense);
    });

    Expense expense2 = Expense(
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
        item: 'phone',
        price: 100);

    test('Expense should have params but wrong data', () {
      expect(expense2.price, isNot(200));

      expect(expense2.item, isNot('food'));

      expect(expense2.barColor,
          isNot(charts.ColorUtil.fromDartColor(Colors.purple)));
    });
  });

  group('User model', () {
    Income income = Income(income: 200);

    test('Income should have alue', () {
      expect(income.income, isNotNull);
      expect(income.income, 200);
      expect(income.runtimeType, Income);
    });

    Income emptyIncome = Income();

    test('Income should not have value', () {
      expect(emptyIncome.income, isNull);
    });
  });

  group('User model', () {
    User user = User(uid: 'ddaaska');

    test('User should have value', () {
      expect(user.uid, 'ddaaska');

      expect(user.runtimeType, User);

      expect(user.uid, isNotNull);
    });

    User emptyUser = User();

    test('User should not have value', () {
      expect(emptyUser.uid, isNot('ddaaska'));

      expect(emptyUser.uid, isNull);
    });
  });

  group('WeekExpense Tests', () {
    WeekExpense weekExpense = WeekExpense(
        expenditure: 200,
        weekDayDate: '2/12/2019',
        weekDay: 'Mon',
        barColor: charts.ColorUtil.fromDartColor(Colors.purple));

    test('Expense should have all right values', () {
      expect(weekExpense.runtimeType, WeekExpense);
      expect(weekExpense.expenditure, 200);
      expect(
        weekExpense.weekDayDate,
        '2/12/2019',
      );
      expect(weekExpense.weekDay, 'Mon');
      expect(
          weekExpense.barColor, charts.ColorUtil.fromDartColor(Colors.purple));
    });

    test('Expense has no values', () {
      expect(weekExpense.expenditure, isNot(2030));
      expect(
          weekExpense.weekDayDate,
          isNot(
            '2/13/2019',
          ));
      expect(weekExpense.weekDay, isNot('Tues'));
      expect(weekExpense.barColor,
          isNot(charts.ColorUtil.fromDartColor(Colors.red)));
    });
  });
}
