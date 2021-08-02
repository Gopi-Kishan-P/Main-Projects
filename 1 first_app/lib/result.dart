import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final Function reset;
  Result(this.score, this.reset);

  String get res {
    if (score >= 15) return "You are soooo Goooood";
    if (score >= 10) return "You are can be Better";
    if (score >= 5) return "You are OK-ish";
    return "You are soooo Bad";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text(
          "Your Score : " + score.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            
          ),
        ),
        Text(
          res,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 50,
          ),
        ),
        ElevatedButton(onPressed: reset, child: Text("Reset"))
      ],
    ));
  }
}
