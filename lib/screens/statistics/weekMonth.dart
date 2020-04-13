import 'package:expensetracker/Components/customCard.dart';
import 'package:expensetracker/Components/customText.dart';
import 'package:expensetracker/Constants/Colors.dart';
import 'package:expensetracker/Services/databaseService.dart';
import 'package:expensetracker/models/weekMonthData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class WeekMonth extends StatefulWidget {

  static String id = 'weekMonth';

  final WeekMonthData weekMonthData;

  WeekMonth({Key key, @required this.weekMonthData}) : super(key :key);



  @override
  _WeekMonthState createState() => _WeekMonthState();
}

class _WeekMonthState extends State<WeekMonth> {

  Future _getWeekExpenses;
  Future _getWeekIncome;

  @override
  void initState() {

   super.initState();

   _getWeekExpenses =  DatabaseService().getWeekDataFromRange( weekMonthData: widget.weekMonthData );
   _getWeekIncome = DatabaseService().getWeekTotalIncome( weekMonthData:  widget.weekMonthData );

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(

      child: Scaffold(
        appBar: AppBar( title: Text('${ widget.weekMonthData.weekName }'),),

        body:   Column(

          children: <Widget>[


            Container(
              margin: EdgeInsets.only(top: 20.0, bottom:  5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  CustomText(
                    text: 'Total expenditure : ${widget.weekMonthData.expenditure}',
                    textColor: Colors.black,
                    fontFamily: 'open sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),

                  SizedBox(height: 5.0,),

                  FutureBuilder(
                    future: _getWeekIncome ,
                    builder: (context,snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child:  Center(
                                child:  CircularProgressIndicator(backgroundColor: Colors.green[200],)
                            ),
                          );
                        case ConnectionState.none:
                        case ConnectionState.done:

                          if(!snapshot.hasData ){
                            return CustomText(
                              text: 'Total Income : 0',
                              textColor: Colors.black,
                              fontFamily: 'open sans',
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0,
                            );
                          }

                          if(snapshot.hasData){
                            var data = snapshot.data;

                            return CustomText(
                                text: 'Total Income : $data',
                                textColor: Colors.black,
                                fontFamily: 'open sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0,
                              );


                          }

                      }
                      return  Center( child: Text('No Content'),);
                    },
                  )

                ],
              ),
            ),

            FutureBuilder(
              future: _getWeekExpenses ,
              builder: (context,snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child:  Center(
                            child:  CircularProgressIndicator(backgroundColor: Colors.green[300],)
                        ),
                    );
                  case ConnectionState.none:
                  case ConnectionState.done:

                    if(!snapshot.hasData ){
                      return Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 20.0),
                        child: Center(
                          child:   CustomText(
                            text: 'No records found',
                            textColor: Colors.black,
                            fontFamily: 'open sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
                        )
                      );
                    }

                    if(snapshot.hasData){
                      var data = snapshot.data;

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context , index){

                            return Row(
                              children: <Widget>[

                                Expanded(
                                  child: ListTile(

                                    title: CustomText(
                                      text: '${data[index].item}',
                                      textColor: Colors.black,
                                      fontFamily: 'open sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0,
                                    ),
                                    leading: Icon(Icons.view_week),
                                    subtitle: CustomText(
                                      text: '${data[index].price}',
                                      textColor: Colors.black,
                                      fontFamily: 'open sans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                    ),

                                  ),
                                ),

                                Expanded(
                                    child: CustomText(
                                      text: '${data[index].dateRecorded} ${data[index].timeRecorded}',
                                      textColor: Colors.black,
                                      fontFamily: 'open sans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0,
                                    ),

                                ),
                              ],
                            );

                          });
                    }

                }
                return  Center( child: Text('No Content'),);
              },
            ),
          ],
        ),
      ),
    );
  }


}
