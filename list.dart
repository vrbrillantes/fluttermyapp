import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/event-banner.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

final googleSignIn = new GoogleSignIn();
final analytics = new FirebaseAnalytics();
final auth = FirebaseAuth.instance;

class FriendlychatApp extends StatefulWidget {
  const FriendlychatApp();
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<StatefulWidget> {
  final reference = FirebaseDatabase.instance.reference().child('HELLO').child('Events');

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
      home: new Scaffold(
        appBar: new AppBar(title: new Text("Friendlychat")),
        body: new Column(children: <Widget>[
          new Flexible(
            child: new FirebaseAnimatedList(
              query: reference.orderByChild("Attendees/vcbrillantesglobecomph").equalTo(true),
              sort: (a, b) => b.key.compareTo(a.key),
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) {
                return new EventBanner(snapshot: snapshot, animation: animation);
              })
          ),
        ]),
      ),
    );
  }
}
