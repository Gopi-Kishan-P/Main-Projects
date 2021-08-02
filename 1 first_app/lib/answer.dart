import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answer;
  final Function _answered;
  Answer(this.answer, this._answered);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          this.answer,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _answered,
      ),
    );
  }
}
