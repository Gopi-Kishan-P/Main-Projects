import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filter_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: EdgeInsets.all(20),
            color: Color(0xff7e60c2),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
                fontSize: 36,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.restaurant),
              title: Text(
                'Meals',
                style: TextStyle(
                    color: Color(0xff7e60c2),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed'),
              ),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Filter',
              style: TextStyle(
                  color: Color(0xff7e60c2),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoCondensed'),
            ),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
