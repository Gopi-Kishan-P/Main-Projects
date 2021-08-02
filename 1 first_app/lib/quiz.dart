import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> qa;
  final Function answered;
  final int i;

  Quiz({this.qa, this.i, this.answered});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Question(qa[i]["question"]),
      ...(qa[i]["answer"] as List<Map<String,Object>>)
          .map((answer) => Answer(answer["text"], () => answered(answer['score'])))
          .toList()
    ]);
  }
}
