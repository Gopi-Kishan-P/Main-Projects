import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String question;

  Question(this.question);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 3,vertical: 18),
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Text(
        this.question,
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
