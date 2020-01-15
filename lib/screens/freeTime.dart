import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_manager/classes/pair.dart';
import 'package:schedule_manager/classes/person.dart';

class FreeTime extends StatefulWidget {

  List<Person> people;


  FreeTime(this.people);

  @override
  _FreeTimeState createState() => _FreeTimeState(people);
}

class _FreeTimeState extends State<FreeTime> {

  List<Person> people;

  _FreeTimeState(this.people);

  List scheduleMonday=[];
  List scheduleTuesday=[];
  List scheduleWednesday=[];
  List scheduleThursday=[];
  List scheduleFriday=[];
  List scheduleSaturday=[];
  List scheduleSunday=[];

  List days=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];

  bool _isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    populateFreeSchedule();
  }

  @override
  Widget build(BuildContext context) {
//    print(people[0].name);
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Time'),
      ),
      body: ListView.builder(itemCount: days.length,itemBuilder: (context,day){
        return Card(
          child: ExpansionTile(
            title: Text(days[day]),
            children: <Widget>[
              showFreeSchedule(day)
            ],
          ),
        );
      }),
    );
  }

  showFreeSchedule(int day) {
//    print('hello');
    List scheduleDayList;
    if(day==0)
      scheduleDayList=scheduleMonday;
    else if(day==1)
      scheduleDayList=scheduleTuesday;
    else if(day==2)
      scheduleDayList=scheduleWednesday;
    else if(day==3)
      scheduleDayList=scheduleThursday;
    else if(day==4)
      scheduleDayList=scheduleFriday;
    else if(day==5)
      scheduleDayList=scheduleSaturday;
    else if(day==6)
      scheduleDayList=scheduleSunday;

//    print('Listview1');
//    print(scheduleDayList);
//    print('ends1');
    return ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: scheduleDayList.length,itemBuilder: (context,index){
//      if(_isLoading)
//        return Center(child: CircularProgressIndicator());
//    print('Listview');
//    print(scheduleDayList);
//    print('ends');
      return Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Free Hours: ',textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
            Text(duration(scheduleDayList[index]),textAlign:TextAlign.center,style: TextStyle(fontSize: 18),),
          ],
        ),
      );
    });


  }

  String duration(Pair pair){
    return pair.left.hour.toString()+':'+pair.left.minute.toString()+' - '+pair.right.hour.toString()+':'+pair.right.minute.toString();
  }

  void populateFreeSchedule() async {
    setState(() {
      _isLoading=true;
    });
    for(int day=0;day<days.length;day++){
//      List scheduleDayList;
      List busyHours=[];
      for(int index=0;index<people.length;index++){
        var snapshot=await Firestore.instance.collection('user').document(people[index].docId).collection(days[day]).getDocuments();
        int snapshotLength=snapshot.documents.length;
        for(int snapshotIndex=0;snapshotIndex<snapshotLength;snapshotIndex++){
          busyHours.add(Pair.fromMapObject(snapshot.documents[snapshotIndex].data));

        }
      }
//      print(busyHours);
      if(day==0)
        scheduleMonday=findFreeHours(busyHours);
      else if(day==1)
        scheduleTuesday=findFreeHours(busyHours);
      else if(day==2)
        scheduleWednesday=findFreeHours(busyHours);
      else if(day==3)
        scheduleThursday=findFreeHours(busyHours);
      else if(day==4)
        scheduleFriday=findFreeHours(busyHours);
      else if(day==5)
        scheduleSaturday=findFreeHours(busyHours);
      else if(day==6)
        scheduleSunday=findFreeHours(busyHours);
//      scheduleDayList=findFreeHours(busyHours);
//      print('final');
//      print(scheduleDayList);
      setState(() {

      });

    }



    setState(() {
      _isLoading=false;
    });

  }

  List findFreeHours(List busyHours) {
    List scheduleDayList=[];
    busyHours.sort((a,b){
      if(a.left.hour<b.left.hour)
        return -1;
      else if(a.left.hour==b.left.hour){
        if(a.left.minute<b.left.minute)
          return -1;
        else if(a.left.minute==b.left.minute)
          return 0;
        else
          return 1;
      }
      else
        return 1;
    });
    print(busyHours);
//    Pair pair;
//    var map=Map<String,int>();
    TimeOfDay endTime=TimeOfDay(hour: 0,minute: 0);
    if(busyHours.length!=0 && busyHours[0].left.hour!=0 && busyHours[0].left.minute!=0) {
      scheduleDayList.add(
          getPair(0, 0, busyHours[0].left.hour, busyHours[0].left.minute));
      endTime=TimeOfDay(hour:busyHours[0].right.hour,minute: busyHours[0].right.minute);

    }

    for(int index=0;index<busyHours.length-1;index++){
      if(compare(endTime,busyHours[index+1].left)){
        scheduleDayList.add(getPair(endTime.hour,endTime.minute,busyHours[index+1].left.hour,busyHours[index+1].left.minute));
        endTime=TimeOfDay(hour: busyHours[index+1].left.hour,minute: busyHours[index+1].left.minute);
      }
      if(compare(endTime,busyHours[index+1].right)){
        endTime=busyHours[index+1].right;
      }
    }
    if(compare(endTime,TimeOfDay(hour: 23,minute: 59))){
      scheduleDayList.add(getPair(endTime.hour, endTime.minute, 23, 59));
    }

    print(scheduleDayList);print('Sorted list');
    return scheduleDayList;

  }

  getPair(int sh,int sm,int eh,int em){
    return Pair(TimeOfDay(hour: sh,minute: sm),TimeOfDay(hour: eh,minute: em));
  }
  compare(TimeOfDay left,TimeOfDay right){
    if(left.hour<right.hour)
      return true;
    else if(left.hour==right.hour){
      if(left.minute<right.minute)
        return true;
      else if(left.minute==right.minute)
        return false;
      else
        return false;
    }
    else
      return false;
  }
}
