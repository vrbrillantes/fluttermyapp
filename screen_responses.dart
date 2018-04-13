// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'item_questions.dart';
import 'ui_expanding.dart';
import 'ui_collapsible.dart';

class ExpasionPanelsDemo extends StatefulWidget {
  static const String routeName = '/material/expansion_panels';
  List<Question> questionlist = <Question>[];

  ExpasionPanelsDemo({Key key, this.questionlist}) : super(key: key);

  @override
  _ExpansionPanelsDemoState createState() =>
      new _ExpansionPanelsDemoState(questionlist: questionlist);
}

class _ExpansionPanelsDemoState extends State<ExpasionPanelsDemo> {
  List<ItemExpanding<dynamic>> _demoItems = <ItemExpanding<dynamic>>[];
  List<Question> questionlist = <Question>[];

  _ExpansionPanelsDemoState({Key key, this.questionlist});

  @override
  void initState() {
    super.initState();
    print(questionlist);

    void iterateQuestions(value) {
      switch (value.type) {
        case 'R':
          _demoItems.add(new ItemExpanding<double>(
              name: value.question,
              value: 80.0,
              hint: 'Select sun level',
              valueToString: (double amount) => '${amount.round()}',
              builder: (ItemExpanding<double> item) {
                void close() {
                  setState(() {
                    item.isExpanded = false;
                  });
                }

                return new Form(
                    child: new Builder(builder: (BuildContext context) {
                  return new CollapsibleBody(
                    onSave: () {
                      Form.of(context).save();
                      close();
                    },
                    onCancel: () {
                      Form.of(context).reset();
                      close();
                    },
                    child: new FormField<double>(
                      initialValue: item.value,
                      onSaved: (double value) {
                        item.value = value;
                      },
                      builder: (FormFieldState<double> field) {
                        return new Slider(
                          min: 0.0,
                          max: 100.0,
                          divisions: 5,
                          activeColor:
                              Colors.orange[100 + (field.value * 5.0).round()],
                          label: '${field.value.round()}',
                          value: field.value,
//                          onChanged: field.onChanged,
                        );
                      },
                    ),
                  );
                }));
              }));
          break;
        case 'V':
          _demoItems.add(
            new ItemExpanding<String>(
                name: value.question,
                value: "",
                hint: 'Select location',
                valueToString: (String location) => location,
                builder: (ItemExpanding<String> item) {
                  void close() {
                    setState(() {
                      item.isExpanded = false;
                    });
                  }

                  return new Form(
                      child: new Builder(builder: (BuildContext context) {
                    return new CollapsibleBody(
                      onSave: () {
                        Form.of(context).save();
                        close();
                      },
                      onCancel: () {
                        Form.of(context).reset();
                        close();
                      },
                      child: new FormField<String>(
                          initialValue: item.value,
                          onSaved: (String result) {
                            item.value = result;
                          },
                          builder: (FormFieldState<String> field) {
                            List<Widget> choicesRows = <Widget>[];
                            void iterateChoices(vv) {
                              choicesRows.add(new Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Radio<String>(
                                        value: vv.choice,
                                        groupValue: field.value,
//                                        onChanged: field.onChanged
                                    ),
                                    new Text(vv.choice)
                                  ]));
                            }

                            value.choiceList.forEach(iterateChoices);
                            return new Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: choicesRows);
                          }),
                    );
                  }));
                }),
          );
          break;
        default:
          _demoItems.add(new ItemExpanding<String>(
            name: value.question,
            value: 'Caribbean cruise',
            hint: 'Change trip name',
            valueToString: (String value) => value,
            builder: (ItemExpanding<String> item) {
              void close() {
                setState(() {
                  item.isExpanded = false;
                });
              }

              return new Form(
                child: new Builder(
                  builder: (BuildContext context) {
                    return new CollapsibleBody(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      onSave: () {
                        Form.of(context).save();
                        close();
                      },
                      onCancel: () {
                        Form.of(context).reset();
                        close();
                      },
                      child: new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: new TextFormField(
                          controller: item.textController,
                          decoration: new InputDecoration(
                            hintText: item.hint,
                            labelText: item.name,
                          ),
                          onSaved: (String value) {
                            item.value = value;
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ));
          break;
      }
    }

    questionlist.forEach(iterateQuestions);
//    _demoItems = <ItemExpanding<dynamic>>[
//    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('Expansion panels')),
      body: new SingleChildScrollView(
        child: new SafeArea(
          top: false,
          bottom: false,
          child: new Container(
            margin: const EdgeInsets.all(24.0),
            child: new ExpansionPanelList(
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    _demoItems[index].isExpanded = !isExpanded;
                  });
                },
                children: _demoItems.map((ItemExpanding<dynamic> item) {
                  return new ExpansionPanel(
                      isExpanded: item.isExpanded,
                      headerBuilder: item.headerBuilder,
                      body: item.build());
                }).toList()),
          ),
        ),
      ),
    );
  }
}
