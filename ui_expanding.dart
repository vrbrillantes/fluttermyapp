import 'package:flutter/material.dart';
import 'ui_hintedheader.dart';

typedef Widget DemoItemBodyBuilder<T>(ItemExpanding<T> item);
typedef String ValueToString<T>(T value);
class ItemExpanding<T> {
  ItemExpanding({
    this.name,
    this.value,
    this.hint,
    this.builder,
    this.valueToString
  }) : textController = new TextEditingController(text: valueToString(value));

  final String name;
  final String hint;
  final TextEditingController textController;
  final DemoItemBodyBuilder<T> builder;
  final ValueToString<T> valueToString;
  T value;
  bool isExpanded = false;

  ExpansionPanelHeaderBuilder get headerBuilder {
    return (BuildContext context, bool isExpanded) {
      return new DualHeaderWithHint(
          name: name,
          value: valueToString(value),
          hint: hint,
          showHint: isExpanded
      );
    };
  }

  Widget build() => builder(this);
}