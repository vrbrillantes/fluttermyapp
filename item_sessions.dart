import 'item_questions.dart';

class Session {
  final String key;
  String name;
  String eventday;
  String starttime;
  String endtime;
  String eventID;
  List<Question> questionlist = <Question>[];

  Session.fromJson(this.key, Map data) {
    void iterateQuestions(key, value) {
      print('$key:$value');//string interpolation in action
      questionlist.insert(questionlist.length, new Question.fromJson(key, value));
    }
    name = data['Name'];
    eventday = data['EventDay'];
    starttime = data['StartTime'];
    endtime = data['EndTime'];
    eventID = data['EventID'];
    if(data['SessionQuestions'] != null) data['SessionQuestions'].forEach(iterateQuestions);
  }
}
class Sessions {
  final String key;
  List<Session> sessionlist = <Session>[];

  Sessions.fromJson(this.key, Map data) {
    void iterateMapEntry(key, value) {
      print('$key:$value');//string interpolation in action
      sessionlist.insert(sessionlist.length, new Session.fromJson(key, value));
    }
    data.forEach(iterateMapEntry);
  }
}