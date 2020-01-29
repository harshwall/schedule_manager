import 'package:flutter/material.dart';
import 'package:schedule_manager/screens/homePage.dart';
import 'package:schedule_manager/screens/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/person.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    print('hello');
    final String jsonName=prefs.getString('name');
    final String jsonDocId=prefs.getString('docId');
    print('hey');

    if(jsonName==null || jsonName.isEmpty || jsonDocId==null || jsonDocId.isEmpty) {
//      print('inside if');
      Person person=Person('','');
      print(person.name);
      return runApp(MyApp(person));
    }
    else {
//      print('outside if');
      return runApp(MyApp(Person(jsonName,jsonDocId)));
    }
  });
//  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Person person;
  MyApp(this.person);
  @override
  Widget build(BuildContext context) {
    print(person.name+' saket');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: person.name==''?SignUp(person):HomePage(person),
    );
  }
}