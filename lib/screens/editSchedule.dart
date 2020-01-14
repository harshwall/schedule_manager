import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:schedule_manager/classes/pair.dart';

class EditSchedule extends StatefulWidget {
  @override
  _EditScheduleState createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  bool _isLoading=false;
  DateTime dateTime;
  String _docId='ejlm8O1vN4xx2U6uCznl';
  List scheduleMonday=[];
  List scheduleTuesday=[];
  List scheduleWednesday=[];
  List scheduleThursday=[];
  List scheduleFriday=[];
  List scheduleSaturday=[];
  List scheduleSunday=[];

  List days=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
//  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBusyHour();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add busy hours'),
      ),
      body: ListView(
        children: <Widget>[
          editScheduleWeekList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 10.0,
                  child: _isLoading?CircularProgressIndicator(strokeWidth: 2.0,):Text('Submit'),
                  onPressed: _isLoading?null:(){uploadBusyHours();},
                ),
              ],
            )
        ],
      ),
    );
  }
  Widget editScheduleWeekList(){
//    return ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: days.length,itemBuilder: (BuildContext context,int index){
//      return FutureBuilder(
//        future: Firestore.instance.collection('user').document(_docId).collection(days[index]).getDocuments(),
//        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> asyncSnapshot){
//          if(!asyncSnapshot.hasData)
//            return Card(
//              child: ExpansionTile(
//                title: Text(days[index]),
//                children: <Widget>[
//                  CircularProgressIndicator()
//                ],
//              ),
//            );
//          return Card(
//            child: ExpansionTile(
//              title: Text(days[index]),
//              children: <Widget>[
//                editScheduleDay(index,asyncSnapshot)
//              ],
//            ),
//          );
//      },
//      );
//    });

    return ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: days.length,itemBuilder: (BuildContext context,int index){
      return Card(
        child: ExpansionTile(
          title: Text(days[index]),
          children: <Widget>[
            editScheduleDay(index)
          ],
        ),
      );
    });
  }

  Widget editScheduleDay(int day){
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

//    int asyncSnapshotLength=asyncSnapshot.data.documents.length;
//    for(int index=0;index<asyncSnapshotLength;index++){
//      scheduleDayList=[];
//      scheduleDayList.add(Pair.fromMapObject(asyncSnapshot.data.documents[index].data));
//    }
    //NeverScrollableScrollPhysics() does not allow particular ListView to scroll
    return ListView.builder(physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: scheduleDayList.length+1,itemBuilder: (BuildContext context,int index){

//      print(index);
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
                onPressed: _isLoading?null:(){deleteTime(scheduleDayList,index);},

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

  void uploadBusyHours() async {
//    dateTime=DateTime.now();
    setState(() {
      _isLoading=true;
    });
//    print(dateTime.toString());
//    print('Uploading');
    for(int day=0;day<days.length;day++) {
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
      await uploadScheduleDay(scheduleDayList,day);
//      for (int busyHour = 0; busyHour<scheduleDayList.length;busyHour++)
//        Firestore.instance.collection('user').document(_docId).collection(days[day]).add(scheduleDayList[busyHour].toMap());
    }
//    print('Uploaded');
//    toast('uploaded');
    setState(() {
      _isLoading=false;
    });
//    print(DateTime.now().toString());
  }

  void uploadScheduleDay(List scheduleDayList,int day) async {
    var snapshots=await Firestore.instance.collection('user').document(_docId).collection(days[day]).getDocuments();
    int snapshotCount=snapshots.documents.length;
    for(int index=0;index<snapshotCount;index++)
      await Firestore.instance.collection('user').document(_docId).collection(days[day]).document(snapshots.documents[index].documentID).delete();

    for (int busyHour = 0; busyHour<scheduleDayList.length;busyHour++)
      Firestore.instance.collection('user').document(_docId).collection(days[day]).add(scheduleDayList[busyHour].toMap());


  }

  void fetchBusyHour() async {
    _isLoading=true;
    setState(() {

    });
    for(int day=0;day<days.length;day++){
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
      var snapshot=await Firestore.instance.collection('user').document(_docId).collection(days[day]).getDocuments();
      int documentsLength=snapshot.documents.length;
      for(int index=0;index<documentsLength;index++){
        scheduleDayList.add(Pair.fromMapObject(snapshot.documents[index].data));
      }
      setState(() {

      });
    }
    _isLoading=false;
    setState(() {

    });

  }
  
}
