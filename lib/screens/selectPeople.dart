import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_manager/classes/person.dart';
import 'package:schedule_manager/screens/freeTime.dart';

class SelectPeople extends StatefulWidget {

  Person person;

  SelectPeople(this.person);

  @override
  _SelectPeopleState createState() => _SelectPeopleState(person);
}

class _SelectPeopleState extends State<SelectPeople> {
  Person person;
  _SelectPeopleState(this.person);

  List<bool> checkboxValue=[];
  List<Person> people=[];
  bool _isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();

  }

  @override
  Widget build(BuildContext context) {
//    print(person.docId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Select people'),
      ),
      body: ListView.builder(itemCount: checkboxValue.length+1,itemBuilder: (context,index){
        if(checkboxValue.length==0)
          return Center(child: Icon(Icons.cloud_done),);
        else if(index!=checkboxValue.length)
          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0,0.0,10.0,0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(people[index].name),
                  Checkbox(
                    value: checkboxValue[index],
                    onChanged: (bool value){
                      print(value.toString()+checkboxValue[index].toString());
                      setState(() {
                        checkboxValue[index]=value;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        else{
          return RaisedButton(
              color: Colors.black,
              child: _isLoading?CircularProgressIndicator():Text('Free Time!', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 10.0,
              onPressed: _isLoading?null:() {
                calcFreeTime();

              }
          );
        }
      }),
    );
  }

  void fetchData() async {
    setState(() {
      _isLoading=true;
    });
    var snapshot= await Firestore.instance.collection('user').getDocuments();
    int itemCount=snapshot.documents.length;
    for(int index=0;index<itemCount;index++) {
      Person p=Person.fromMapObject(snapshot.documents[index].data);
      p.docId=snapshot.documents[index].documentID.toString();
//      print(p.docId.toString()+'   '+person.docId.toString());
      if(p.docId==person.docId)
        continue;
      people.add(p);
      checkboxValue.add(false);
    }
    setState(() {
      _isLoading=false;
    });

  }

  void calcFreeTime() {
    List<Person> docIds=[];
    docIds.add(person);
    for(int i=0;i<people.length;i++)
      if(checkboxValue[i]==true)
        docIds.add(people[i]);
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>FreeTime(docIds)));


  }
}
