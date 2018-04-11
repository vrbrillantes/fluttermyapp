import 'package:flutter/material.dart';
import 'item_sessions.dart';
import 'screen_responses.dart';
import 'screen_sessions.dart';
class EventBanner extends StatelessWidget {
  EventBanner({this.snapshot}); // modified
  final Session snapshot; // modified
//  final Animation animation;

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Text(snapshot.name,
            style: Theme.of(context).textTheme.display1),
        new ListTile(
          leading: new Icon(Icons.date_range),
          // ignore: const_eval_throws_exception
          title: new Text(snapshot.starttime,
              style: Theme.of(context).textTheme.subhead),
          subtitle: new Text(snapshot.eventday),
        ),
        new ButtonTheme.bar(
          child: new ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              new FlatButton(
                child: const Text('Rate'),
                textColor: Colors.amber.shade500,
                onPressed: () {
                  /* do nothing */
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new ExpasionPanelsDemo(questionlist: snapshot.questionlist)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}