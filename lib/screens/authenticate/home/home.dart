import 'package:firebase/models/brew.dart';
import 'package:firebase/screens/authenticate/home/settings_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/screens/authenticate/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          color: Colors.amberAccent,
          padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }
    
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('settings'),
                onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
