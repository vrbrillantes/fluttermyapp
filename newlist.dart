//import 'package:flutter/material.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:my_app/event-banner.dart';
//import 'package:my_app/nav_iconview.dart';
//import 'package:my_app/list.dart';
//import 'package:my_app/nav_customicon.dart';
//import 'package:firebase_database/firebase_database.dart';         //new
//import 'package:firebase_database/ui/firebase_animated_list.dart';
//
//final googleSignIn = new GoogleSignIn();
//final analytics = new FirebaseAnalytics();
//final auth = FirebaseAuth.instance;
//
//
//class UnFriendlychatApp extends StatefulWidget {
//  const UnFriendlychatApp();
//  State createState() => new UnChatScreenState();
//}
//
//class UnChatScreenState extends State<StatefulWidget> with TickerProviderStateMixin {
//  final reference = FirebaseDatabase.instance.reference().child('HELLO').child('Events');
//  int _currentIndex = 0;
//  List<NavigationIconView> _navigationViews;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _navigationViews = <NavigationIconView>[
//      new NavigationIconView(
//        icon: const Icon(Icons.access_alarm),
//        title: 'Alarm',
//        color: Colors.deepPurple,
//        vsync: this,
//      ),
////      new NavigationIconView(
////        icon: new CustomIcon(),
////        title: 'Box',
////        color: Colors.deepOrange,
////        vsync: this,
////      ),
//      new NavigationIconView(
//        icon: const Icon(Icons.cloud),
//        title: 'Cloud',
//        color: Colors.teal,
//        vsync: this,
//      ),
////      new NavigationIconView(
////        icon: const Icon(Icons.favorite),
////        title: 'Favorites',
////        color: Colors.indigo,
////        vsync: this,
////      ),
//      new NavigationIconView(
//        icon: const Icon(Icons.event_available),
//        title: 'Event',
//        color: Colors.pink,
//        vsync: this,
//      )
//    ];
//
//    for (NavigationIconView view in _navigationViews)
//      view.controller.addListener(_rebuild);
//
//    _navigationViews[_currentIndex].controller.value = 1.0;
//
//  }
//  void _rebuild() {
//    setState(() {
//      // Rebuild in order to animate views.
//    });
//  }
//  @override                                                      //new
//  Widget build(BuildContext context) {
//    final BottomNavigationBar botNavBar = new BottomNavigationBar(
//      items: _navigationViews.map((NavigationIconView navigationView) => navigationView.item).toList(),
//      currentIndex: _currentIndex,
//      type: BottomNavigationBarType.fixed,
//      onTap: (int index) {
////        Navigator.of(context).pushNamed('/screen1'); //2
//        setState(() {
//          _navigationViews[_currentIndex].controller.reverse();
//          _currentIndex = index;
//          _navigationViews[_currentIndex].controller.forward();
//
//        });
//      },
//    );
//    return new MaterialApp(
//      title: "Friendlychat",
//      home: new Scaffold(
//        appBar: new AppBar(title: new Text("Friendlychat 2")),
//        body: new Column(children: <Widget>[
//          new Flexible(
//              child: new FirebaseAnimatedList(
////                  query: reference.orderByChild("Attendees/vcbrillantesglobecomph").equalTo(true),
//                  query: reference.orderByChild("Public").equalTo(true),                                     //new
//                  sort: (a, b) => b.key.compareTo(a.key),                 //new
//                  padding: new EdgeInsets.all(8.0),                       //new
//                  reverse: true,
//                  itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) {
//                    return new EventBanner(snapshot: snapshot, animation: animation);
//                  })
//          ),
//        ]),
//        bottomNavigationBar: botNavBar,
//      ),
//
//      routes: <String, WidgetBuilder> { //5
//        '/screen1': (BuildContext context) => new FriendlychatApp(), //6
//        '/screen2' : (BuildContext context) => new UnFriendlychatApp() //7
//      },
//    );
//  }
//
//
//}
