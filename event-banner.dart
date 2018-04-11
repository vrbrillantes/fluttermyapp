import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EventBanner extends StatelessWidget {
  EventBanner({this.snapshot, this.animation}); // modified
  final DataSnapshot snapshot; // modified
  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Card(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.network(snapshot.value['Banner']),
              new Text(snapshot.value['Name'],
                  style: Theme.of(context).textTheme.subhead),
            ],
          ),
        ),
        new ListTile(
          leading: new Icon(Icons.date_range),
          // ignore: const_eval_throws_exception
          title: new Text(snapshot.value['StartDate'],
              style: Theme.of(context).textTheme.subhead),
          subtitle: new Text(snapshot.value['Venue']),
        ),
        new ButtonTheme.bar(
          child: new ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              new FlatButton(
                child: const Text('SHARE'),
                textColor: Colors.amber.shade500,
                onPressed: () {
                  /* do nothing */
                },
              ),
              new FlatButton(
                child: const Text('EXPLORE'),
                textColor: Colors.amber.shade500,
                onPressed: () {
                  /* do nothing */
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
