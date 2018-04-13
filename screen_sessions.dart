import 'dart:async';
import 'package:flutter/material.dart';
import 'item_todo.dart';
import 'item_sessions.dart';
//import 'item_todos.dart';
import 'ui_sessionbanner.dart';
import 'util_firebase.dart';
import 'nav_iconview.dart';
import 'nav_customicon.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen_responses.dart';

final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance;

class ScreenSessions extends StatelessWidget {
  String eventID;
  ScreenSessions({Key key, this.eventID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new HomePage(eID: eventID);
  }
}
class HomePage extends StatefulWidget {
  HomePage({Key key, this.eID}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState(eID: eID);
  String eID;
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  String eID;
  _HomePageState({this.eID});
  List<Session> _messages = <Session>[];
  StreamSubscription _subscriptionTodo;

  @override
  void initState() {
    FirebaseTodos.getSessions(eID, _updateTodo)
        .then((StreamSubscription s) => _subscriptionTodo = s);
    super.initState();
  }

  @override
  void dispose() {
    if (_subscriptionTodo != null) {
      _subscriptionTodo.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("App Bar Title"),
      ),
      body: new ListView.builder(
        padding: new EdgeInsets.all(8.0),
        itemCount: _messages.length,
        itemBuilder: (_, int index) {
          return new EventBanner(snapshot: _messages[index]);
        },
      ),
    );
  }


  _updateTodo(Sessions value) {
    var name = value.sessionlist;
    setState((){
      _messages = name;
    });
  }
}











