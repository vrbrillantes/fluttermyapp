import 'item_todo.dart';
import 'item_sessions.dart';
import 'util_preferences.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class FirebaseTodos {
  /// FirebaseTodos.getTodoStream("-KriJ8Sg4lWIoNswKWc4", _updateTodo)
  /// .then((StreamSubscription s) => _subscriptionTodo = s);
  static Future<StreamSubscription<Event>> getTodoStream(String todoKey,
      void onData(Todos todo)) async {
    String accountKey = await Preferences.getAccountKey();

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child('HELLO')
        .child('Events')
//        .child('-L56EyFw3Ymm3o6A56jM')
        .orderByChild(accountKey)
        .equalTo(true)
        .onValue
        .listen((Event event) {
      var todos = new Todos.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todos);
    });

    return subscription;
  }
  static Future<StreamSubscription<Event>> getSessions(String todoKey,
      void onData(Sessions todo)) async {

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child('HELLO')
        .child('Modules')
        .orderByChild("EventID")
        .equalTo(todoKey)
        .onValue
        .listen((Event event) {
      var todos = new Sessions.fromJson(event.snapshot.key, event.snapshot.value);
      onData(todos);
    });

    return subscription;
  }
}