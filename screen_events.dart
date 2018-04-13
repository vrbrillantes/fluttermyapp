import 'dart:async';
import 'package:flutter/material.dart';
import 'item_todo.dart';
import 'ui_banner.dart';
import 'util_firebase.dart';
import 'util_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance;

class ScreenEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new HomePage();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<Todo> _messages = <Todo>[];
  Future<String> image;
  StreamSubscription _subscriptionTodo;

  @override
  void initState() {
    FirebaseTodos.getTodoStream("Public", _updateTodo)
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
    return new CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: const Text('Demo'),
          ),
        ),

        new SliverGrid(
          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 4.0,
          ),
          delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return new Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: new Text('grid item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        new SliverFixedExtentList(
          itemExtent: 400.0,
          delegate: new SliverChildBuilderDelegate(
                (_, int index) {
                  return new EventBanner(snapshot: _messages[index]);
//              return new Container(
//                alignment: Alignment.center,
//                color: Colors.lightBlue[100 * (index % 9)],
//                child: new Text('list item $index'),
//              );
            },
            childCount: _messages.length,
          ),
        ),
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("App Bar Title"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: new Image.network("https://lh4.googleusercontent.com/-gEK1m_TuetY/AAAAAAAAAAI/AAAAAAAACrk/xKRbizticDI/s96-c/photo.jpg"),
            tooltip: 'Air it',
//            onPressed: _airDress,
          ),
        ],
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


  _updateTodo(Todos value) {
    var name = value.todolist;
    setState((){
      _messages = name;
    });
  }
}











