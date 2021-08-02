import 'package:first_app/quiz.dart';
import 'package:first_app/result.dart';
import 'package:flutter/material.dart';

import './quiz.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _i = 0;
  var _score = 0;

  static const _qa = [
    {
      "question": "What's Your Favorite Color ?",
      "answer": [
        {"text": "Red", "score": 2},
        {"text": "Blue", "score": 5},
        {"text": "Yellow", "score": 7},
        {"text": "Green", "score": 10}
      ]
    },
    {
      "question": "What's Your Favorite Animal ?",
      "answer": [
        {"text": "Lion", "score": 1},
        {"text": "Tiger", "score": 3},
        {"text": "Cat", "score": 6},
        {"text": "Dog", "score": 9}
      ]
    }
  ];

  void _reset(){
    setState(() {
      _score = 0;
      _i = 0;
    });
  }

  void _answered(int s) {
    _score += s;
    setState(() {
      _i++;
    });
    print(_i);
    print(_score);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Quiz"),
            elevation: 0,
          ),
          body: _i < _qa.length
              ? Quiz(
                  answered: _answered,
                  i: _i,
                  qa: _qa,
                )
              : Result(_score, _reset),
              ),
    );
  }

  void hi() {}
}
