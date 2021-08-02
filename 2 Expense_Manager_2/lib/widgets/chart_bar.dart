import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmt;
  final double spendAmtPer;

  ChartBar({this.label, this.spendAmt, this.spendAmtPer});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(children: <Widget>[
        Container(
          height: constrains.maxHeight * 0.15,
          child: FittedBox(
            child: Text('₹${spendAmt.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(height: constrains.maxHeight * 0.05),
        Container(
          height: constrains.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                    color: Color.fromRGBO(210, 210, 210, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: spendAmtPer,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: constrains.maxHeight * 0.05),
        // Text('${spendAmtPer.toString()}')
        Container(
          height: constrains.maxHeight * 0.15,
          child: FittedBox(
            child: Text(label),
          ),
        )
      ]);
    });
  }
}
