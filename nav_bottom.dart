// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'nav_iconview.dart';
import 'nav_customicon.dart';
import 'package:my_app/event-banner.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class BottomNavigationDemo extends StatefulWidget {
  const BottomNavigationDemo();

  static const String routeName = '/material/bottom_navigation';

  @override
  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState();
}

class _BottomNavigationDemoState extends State<BottomNavigationDemo>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;
  List<NavigationIconView> _navigationViews;
  Query _query = FirebaseDatabase.instance
      .reference()
      .child('HELLO')
      .child('Events');

  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      new NavigationIconView(
        icon: const Icon(Icons.access_alarm),
        title: 'Alarm',
        color: Colors.deepPurple,
        vsync: this,
      ),
      new NavigationIconView(
        icon: new CustomIcon(),
        title: 'Box',
        color: Colors.deepOrange,
        vsync: this,
      ),
      new NavigationIconView(
        icon: const Icon(Icons.cloud),
        title: 'Cloud',
        color: Colors.teal,
        vsync: this,
      )
    ];

    for (NavigationIconView view in _navigationViews)
      view.controller.addListener(_rebuild);

    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _navigationViews) view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAnimatedList fblist = new FirebaseAnimatedList(
        query: _query,
        sort: (a, b) => b.key.compareTo(a.key),
        padding: new EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) {
          return new EventBanner(snapshot: snapshot, animation: animation);
        });
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _navigationViews[_currentIndex].controller.reverse();
          _currentIndex = index;
          _navigationViews[_currentIndex].controller.forward();
          print("HELLOOO");
          _query = FirebaseDatabase.instance
              .reference()
              .child('HELLO')
              .child('Events')
              .orderByChild('Public')
              .equalTo(true);
        });
      },
    );


    return new MaterialApp(
      title: "Friendlychat",
      home: new DefaultTabController(
        length: _navigationViews.length,
        child: new Scaffold(
          appBar: new AppBar(
            title: const Text('Bottom navigation'),
            actions: <Widget>[
              new PopupMenuButton<BottomNavigationBarType>(
                onSelected: (BottomNavigationBarType value) {
                  setState(() {
                    _type = value;
                  });
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuItem<BottomNavigationBarType>>[
                      const PopupMenuItem<BottomNavigationBarType>(
                        value: BottomNavigationBarType.fixed,
                        child: const Text('Fixed'),
                      ),
                      const PopupMenuItem<BottomNavigationBarType>(
                        value: BottomNavigationBarType.shifting,
                        child: const Text('Shifting'),
                      )
                    ],
              )
            ],
          ),
          body: fblist,
//          body: new TabBarView(
//            children:
//                new List<Widget>.generate(1, (index) {
//              switch (_currentIndex) {
//                case 0:
//                  return new Column(children: <Widget>[
//                    new Flexible(
//                        child: new FirebaseAnimatedList(
//                            query: FirebaseDatabase.instance
//                                .reference()
//                                .child('HELLO')
//                                .child('Events')
//                                .orderByChild('Attendees/vcbrillantesglobecomph')
//                                .equalTo(true),
//                            sort: (a, b) => b.key.compareTo(a.key),
//                            padding: new EdgeInsets.all(8.0),
//                            reverse: true,
//                            itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) {
//                              return new EventBanner(snapshot: snapshot, animation: animation);
//                            })
//                    ),
//                  ]);
//                case 1:
//                  return new FirebaseAnimatedList(
//                      query: FirebaseDatabase.instance
//                          .reference()
//                          .child('HELLO')
//                          .child('Events')
//                          .orderByChild('Public')
//                          .equalTo(true),
//                      sort: (a, b) => b.key.compareTo(a.key),
//                      padding: new EdgeInsets.all(8.0),
//                      reverse: true,
//                      itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) {
//                        return new EventBanner(snapshot: snapshot, animation: animation);
//                      });
//                case 2:
//                  return new Center(
//                    child: new Text('Second screen'),
//                  );
//              }
//            }),
//          ),
          bottomNavigationBar: botNavBar,
        ),
      ),
    );
  }
}
