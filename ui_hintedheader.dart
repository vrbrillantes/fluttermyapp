import 'package:flutter/material.dart';

class DualHeaderWithHint extends StatelessWidget {
  const DualHeaderWithHint({
    this.name,
    this.value,
    this.hint,
    this.showHint
  });

  final String name;
  final String value;
  final String hint;
  final bool showHint;

  Widget _crossFade(Widget first, Widget second, bool isExpanded) {
    return new AnimatedCrossFade(
      firstChild: first,
      secondChild: second,
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;

    return new Row(
        children: <Widget>[
          new Expanded(
            flex: 2,
            child: new Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: new FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: new Text(
                  name,
                  style: textTheme.body1.copyWith(fontSize: 15.0),
                ),
              ),
            ),
          ),
          new Expanded(
              flex: 3,
              child: new Container(
                  margin: const EdgeInsets.only(left: 24.0),
                  child: _crossFade(
                      new Text(value, style: textTheme.caption.copyWith(fontSize: 15.0)),
                      new Text(hint, style: textTheme.caption.copyWith(fontSize: 15.0)),
                      showHint
                  )
              )
          )
        ]
    );
  }
}