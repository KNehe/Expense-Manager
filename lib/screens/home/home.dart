import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/screens/addExpense/addExpense.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {

  static String id = 'Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;

  final tabs = [
    AddExpense(),
    Center( child: Text('Statistics'),),
    Center( child: Text('Account'),)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
          child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Statistics')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account')
          )
        ],
        onTap: (index) => setState( ()=> _currentIndex = index ),
        backgroundColor: clipColor,
        selectedItemColor: scaffoldBackgroundColor,
        unselectedFontSize: 14.0,
        selectedFontSize: 15.0,
      ),
    );
  }
}

