import 'package:flutter/material.dart';
import 'package:schedule_manager/classes/person.dart';
import 'package:schedule_manager/screens/editSchedule.dart';
import 'package:schedule_manager/screens/selectPeople.dart';
class HomePage extends StatefulWidget {
  Person person;
  HomePage(this.person);

  @override
  _HomePageState createState() => _HomePageState(person);
}

class _HomePageState extends State<HomePage> {

  Person person;
  _HomePageState(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(person.name),
              currentAccountPicture: Container(
								child: Icon(Icons.person,size: 64,color: Colors.white,),
//                decoration: BoxDecoration(
//                    shape: BoxShape.circle,
////                    image: DecorationImage(
////                        fit: BoxFit.fill,
////                        image: Icon(Icons.cloud)
////                    )
//                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Schedule'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>EditSchedule(person)));
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Select people'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SelectPeople(person)));
              },
            ),
          ],
        ),
      ),
      body: Center(child: Icon(Icons.cloud_done,size: 64,color: Colors.teal,)),
    );
  }
}
