class Question {
  final String key;
  String question;
  bool status;
  String type;

  Question.fromJson(this.key, Map data) {
    question = data['Q'];
    status = data['S'];
    type = data['T'];
  }
}
//class Questions {
//  final String key;
//  List<Question> questionlist = <Question>[];
//
//  Questions.fromJson(this.key, Map data) {
//    void iterateMapEntry(key, value) {
//      questionlist.insert(questionlist.length, new Question.fromJson(key, value));
//    }
//    data.forEach(iterateMapEntry);
//  }
//}