class Question {
  final String key;
  String question;
  bool status;
  String type;
  List<Choice> choiceList = <Choice>[];

  Question.fromJson(this.key, Map data) {
    void iterateChoices(key, value) {
      print('$key:$value');//string interpolation in action
      choiceList.insert(choiceList.length, new Choice.fromJson(key, value));
    }
    question = data['Q'];
    status = data['S'];
    type = data['T'];
    if(data['Choices'] != null) data['Choices'].forEach(iterateChoices);
  }
}
class Choice {
  final String key;
  String choice;

  Choice.fromJson(this.key, String data) {
    choice = data;
  }
}