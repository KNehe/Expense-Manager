import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/screens/account/account.dart';
import 'package:expensetracker/screens/addExpense/addExpense.dart';
import 'package:expensetracker/screens/statistics/statistics.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> tabs;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Key addExpenseKey = PageStorageKey('addExpenseKey');
  final Key statisticsKey = PageStorageKey('statisticsKey');
  final Key accountKey = PageStorageKey('accountKey');

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();

    tabs = [
      AddExpense(
        key: addExpenseKey,
        scaffoldKey: _scaffoldKey,
      ),
      Statistics(
        key: statisticsKey,
        scaffoldKey: _scaffoldKey,
      ),
      Account(
        key: accountKey,
        scaffoldKey: _scaffoldKey,
      )
    ];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: scaffoldBackgroundColor,
      body: PageStorage(
        child: SafeArea(
          child: tabs[_selectedIndex],
        ),
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Statistics'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )
        ],
        onTap: _onItemTapped,
        backgroundColor: bottomNavigationBackgroundColor,
        selectedItemColor: buttonColor,
        unselectedItemColor: clipColor,
        unselectedFontSize: 14.0,
        selectedFontSize: 15.0,
      ),
    );
  }
}
