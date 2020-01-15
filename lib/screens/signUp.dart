import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_manager/classes/person.dart';
import 'package:schedule_manager/screens/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {

  Person person;
  SignUp(this.person);

  @override
  _SignUpState createState() => _SignUpState(person);
}

class _SignUpState extends State<SignUp> {



  Person person;
  _SignUpState(this.person);

  bool _isLoading=false;
  var _signUpForm = GlobalKey<FormState>();
  String name;
  String docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _signUpForm,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (value){
                        person.name=value;
                      },
                      validator: (String value){
                        if(value.length<4)
                          return 'Enter longer name';
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          errorStyle: TextStyle(color: Colors.red),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child:
            RaisedButton(
                color: Colors.black,
                child: _isLoading?CircularProgressIndicator():Text('Login', style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 10.0,
                onPressed: _isLoading?null:() {
                  if(_signUpForm.currentState.validate()){
                    _signUpForm.currentState.save();
                    signUp();
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  void signUp() async {
    _isLoading=true;
    setState(() {
      
    });
    var document=await Firestore.instance.collection('user').add(person.toMap());
    person.docId=document.documentID;
    var sharedPrefs=await SharedPreferences.getInstance();
    sharedPrefs.setString('name', person.name);
    print('setName');
    sharedPrefs.setString('docId', person.docId);
    print('setDocID');
    setState(() {
      _isLoading=false;
    });
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage(person)), (Route<dynamic> route) => false);
    

  }
}
