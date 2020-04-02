



import 'package:expensetracker/Services/authService.dart';
import 'package:expensetracker/models/user.dart';
import 'package:expensetracker/screens/addExpense/addExpense.dart';
import 'package:expensetracker/screens/authenticate/authenticate.dart';
import 'package:expensetracker/screens/authenticate/forgotPassword.dart';
import 'package:expensetracker/screens/authenticate/sign_in_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expensetracker/main.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';




class MockAuth extends Mock implements AuthService{}
void main() {

  Widget createWidgetForTesting( {Widget child}){
    return MaterialApp(
      home: child,
    );

  }


  testWidgets('Sign_in_up Screen Should Display', (WidgetTester tester) async {


    await tester.pumpWidget(createWidgetForTesting(child: SignIn() ));

    expect(find.byType(SafeArea), findsOneWidget);

    expect(find.byType(RaisedButton), findsOneWidget);

    expect(find.byType(TextFormField), findsNWidgets(2));

    expect(find.byType(FlatButton),findsNWidgets(2));

    expect(find.byType(ListView), findsOneWidget);

    //when create an account is clicked
    await tester.tap(find.widgetWithText(FlatButton, 'Create an account'));
    await tester.pump();

    //flat button with 'Have an account'  should exist
    expect(find.widgetWithText(FlatButton, 'Have an account ?'), findsOneWidget);

    //flat button with 'Create an account'  should not exist
    expect(find.widgetWithText(FlatButton, 'Create an account'), findsNothing);

    //when 'Have an account ?' is clicked
    await tester.tap(find.widgetWithText(FlatButton, 'Have an account ?'));
    await tester.pump();

    //flat button with 'Create an account' and 'Forgot Password?' should exist
    expect(find.widgetWithText(FlatButton, 'Create an account'), findsOneWidget);
    expect(find.widgetWithText(FlatButton, 'Forgot password?'), findsOneWidget);

    //flat button with 'Have an account ?'  should not exist
    expect(find.widgetWithText(FlatButton, 'Have an account ?'), findsNothing);
    
  });

  testWidgets('ForgotPassword Screen should display', (WidgetTester tester) async{

    await tester.pumpWidget(createWidgetForTesting(child: ForgotPassword()));

    expect(find.byType(SafeArea), findsOneWidget);

    expect(find.byType(SingleChildScrollView), findsOneWidget);

    expect(find.byType(Form), findsOneWidget);

    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);

    expect(find.widgetWithText(RaisedButton, 'Reset password'), findsOneWidget);

    expect(find.widgetWithText(FlatButton, 'Back ?'), findsOneWidget);

  });

  testWidgets('Authenticate should work without fail', (WidgetTester tester) async{

    await tester.pumpWidget(createWidgetForTesting(child: Authenticate()));

    expect(find.byType(Container), findsWidgets);

    expect(find.byType(SignIn), findsOneWidget);

  });





  testWidgets('Main should display', (WidgetTester tester) async{

    await tester.pumpWidget(createWidgetForTesting(child : MyApp()));

    expect(find.byType(Scaffold), findsOneWidget);


  });


//
//  testWidgets('Home should work', (WidgetTester tester) async{
//
//    GlobalKey<ScaffoldState> scaffoldKey;
//
//    Stream<User> streamUser = new Stream.value(User(uid: 'ss'));
//
//    var service = MockAuth();
//
//   when(service.getUser).thenAnswer( (_)=> streamUser);
//
//    await tester.pumpWidget( createWidgetForTesting(
//
//        child: StreamProvider<User>.value(
//          value: service.getUser,
//          child: AddExpense(scaffoldKey: scaffoldKey,),
//        )
//
//    ));
//  });


}//main

