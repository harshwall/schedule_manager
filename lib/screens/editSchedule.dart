import 'package:flutter/material.dart';

class EditSchedule extends StatefulWidget {
  @override
  _EditScheduleState createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  List scheduleMonday=[];
  List scheduleTuesday=[];
  List scheduleWednesday=[];
  List scheduleThrusday=[];
  List scheduleFriday=[];
  List scheduleSaturday=[];
  List scheduleSunday=[];
//  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Schedule'),
      ),
      body: editScheduleWeekList(),
    );
  }
  Widget editScheduleWeekList(){
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Add busy hours',textAlign:TextAlign.center,style: TextStyle(fontSize: 25),),
        ),
        ExpansionTile(
          title: Text('Monday'),
          children: <Widget>[
            editScheduleDay(0)
          ],
        )

      ],
    );
  }

  Widget editScheduleDay(int day){
    List scheduleDayList;
    scheduleDayList=scheduleMonday;

    return ListView.builder(shrinkWrap: true,itemCount: scheduleDayList.length+1,itemBuilder: (BuildContext context,int index){

      print(index);
      if(index!=scheduleDayList.length)
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Busy Hours: ',textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
              Text(scheduleDayList[index].toString(),textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: (){deleteTime(day,index);},

              )

            ],
          ),
        );
      else
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            color: Colors.black,
            child: GestureDetector(
              onTap: (){print('clicked');addClicked(scheduleDayList);},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add,color: Colors.white,)
                ],
              ),
            ),
          )
        );
    });
  }

  addClicked(List scheduleDayList) async {
    TimeOfDay selectedTime=await showTimePicker(context: context, initialTime: TimeOfDay.now());
    print(selectedTime.toString());
    if(selectedTime!=null)
      scheduleDayList.add(selectedTime);
    setState(() {
      print(scheduleDayList.toString());
    });



  }

  void deleteTime(int day, int index) {}

}
