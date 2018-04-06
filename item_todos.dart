import 'item_todo.dart';
class Todos {
  final String key;
  List<Todo> todolist = <Todo>[];

  Todos.fromJson(this.key, Map data) {
    void iterateMapEntry(key, value) {
      print('$key:$value');//string interpolation in action
      todolist.insert(todolist.length, new Todo.fromJJ(key, value));
    }
    data.forEach(iterateMapEntry);
  }
}