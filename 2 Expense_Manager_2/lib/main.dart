import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.pink),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.blue,
        fontFamily: 'OpenSans',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksans',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: "111",
    //   title: "Shopping",
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "222",
    //   title: "Cutting",
    //   amount: 150,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "333",
    //   title: "Pasting",
    //   amount: 200,
    //   date: DateTime.now(),
    // ),
  ];

  void _addTransaction(String title, double amount, DateTime chosenDate) {
    Transaction t = new Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(t);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _startTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  List<Transaction> get _recentTransaction {
    return _userTransaction
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildLandScape(
      MediaQueryData mediaQuery, AppBar theAppBar, Widget txList) {
    return [
      Row(
        children: <Widget>[
          Text('Display Chart'),
          Switch.adaptive(
              value: _showChart,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {
                // print(value);
                setState(() {
                  _showChart = value;
                });
              }),
        ],
      ),
      _showChart
          ? Container(
              child: Chart(_recentTransaction),
              height: (mediaQuery.size.height -
                      theAppBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.65)
          : txList
    ];
  }

  List<Widget> _buildPortrait(
      MediaQueryData mediaQuery, AppBar theAppBar, Widget txList) {
    return [
      Container(
          child: Chart(_recentTransaction),
          height: (mediaQuery.size.height -
                  theAppBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.25),
      txList
    ];
  }

  Widget _buildIOSAppBar(String title, Function func) {
    return CupertinoNavigationBar(
      middle: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: func,
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    );
  }

  Widget _buildAndroidAppBar(String title, Function func) {
    return AppBar(
      title: Text(title),
      brightness: Brightness.dark,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: func,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget theAppBar = Platform.isIOS
        ? _buildIOSAppBar(
            'Expense Manager',
            () => _startTransaction(context),
          )
        : _buildAndroidAppBar(
            'Expense Manager',
            () => _startTransaction(context),
          );

    final txList = Container(
      height: (mediaQuery.size.height -
              theAppBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.78,
      child: TransactionList(
          transactions: _userTransaction,
          deleteTransaction: _deleteTransaction),
    );

    return Scaffold(
      appBar: theAppBar,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (isLandscape) ..._buildLandScape(mediaQuery, theAppBar, txList),
          if (!isLandscape) ..._buildPortrait(mediaQuery, theAppBar, txList),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        onPressed: () => _startTransaction(context),
      ),
    );
  }
}
