import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schedule_manager/classes/pair.dart';

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
              Text(duration(scheduleDayList[index]),textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
              FlatButton(
                child: Icon(Icons.delete),
                onPressed: (){deleteTime(scheduleDayList,index);},

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
    TimeOfDay startTime=await showTimePicker(context: context, initialTime: TimeOfDay.now());
    print(startTime.toString());
    if(startTime!=null){
      toast(startTime.toString()+' selected');
      TimeOfDay endTime=await showTimePicker(context: context, initialTime: TimeOfDay.now());
      Pair startEndTime=Pair(startTime,endTime);
      if(endTime!=null)
        scheduleDayList.add(startEndTime);
    }
    setState(() {
      print(scheduleDayList.toString());
    });



  }

  void deleteTime(List scheduleDayList, int index) {
    print(scheduleDayList);
    scheduleDayList.removeAt(index);
    setState(() {

    });
    print(scheduleDayList);


  }

  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 10.0
    );
  }

  String duration(Pair pair){
    return pair.left.hour.toString()+':'+pair.left.minute.toString()+' - '+pair.right.hour.toString()+':'+pair.right.minute.toString();
  }
}
