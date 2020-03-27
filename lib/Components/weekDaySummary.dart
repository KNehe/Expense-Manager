import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Services/databaseService.dart';
import 'package:expensetracker/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class  WeekDaySummary{
  final User user;
  final String weekDayDate;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String weekDay;
  final int expenditure;

  WeekDaySummary({@required this.user, @required this.weekDayDate, @required this.scaffoldKey,  @required this.weekDay,  @required this.expenditure});


   showWeekDaySummary(){

     scaffoldKey.currentState.showBottomSheet((context) =>  StreamBuilder(
      stream: DatabaseService(userId: user.uid).searchByWeekDayDate(weekDayDate),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){

        List<ListTile> listTiles = [];

        if(snapshot.hasData && snapshot.data.documents.isNotEmpty){

          for(var doc in snapshot.data.documents){
            var price = doc['Price'];
            var item = doc['Item'];

            var listTile = ListTile(
                leading: Icon(Icons.view_week),
                title: CustomText(
                  text: '$item',
                  textColor: Colors.black,
                  fontFamily: 'open sans',
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                ),
                subtitle:CustomText(
                  text: '$price',
                  textColor: Colors.black54,
                  fontFamily: 'open sans',
                  fontWeight: FontWeight.w500,
                  fontSize: 10.0,
                )
            );
            listTiles.add(listTile);
          }

        }else{
          listTiles.add(ListTile(title: Text('No Records'),));
        }


        return  SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                Row( children: <Widget>[

                  CustomText(
                    text: 'This week on $weekDay:',
                    textColor: Colors.black,
                    fontFamily: 'open sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),

                  SizedBox(width: 10.0,),

                  CustomText(
                    text: 'Expenditure : $expenditure',
                    textColor: Colors.black,
                    fontFamily: 'open sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 15.0,
                  ),


                ],),
                Column(children: listTiles,)
              ],),
            ));

      },
    ));

}
}
