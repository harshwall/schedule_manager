import 'package:flutter/material.dart';
import 'package:schedule_manager/screens/editSchedule.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
//              accountEmail: Text(_user.email),
//              accountName: Text(_user.name),
//              currentAccountPicture: Container(
////								child: Image.network(userDetails.photoUrl),
//                decoration: _user.photoUrl==null?BoxDecoration():BoxDecoration(
//                    shape: BoxShape.circle,
//                    image: DecorationImage(
//                        fit: BoxFit.fill,
//                        image: NetworkImage(_user.photoUrl)
//                    )
//                ),
//              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Schedule'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>EditSchedule()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
