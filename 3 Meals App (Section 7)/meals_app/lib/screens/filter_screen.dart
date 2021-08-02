import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';

  final Function setFilter;
  Map<String,bool> filters;
  FilterScreen(this.filters, this.setFilter);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState(){
    super.initState();
    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _vegan = widget.filters['vegan'];
    _vegetarian = widget.filters['vegeterian'];
  }

  Widget _buildSwitchTile({
    String title,
    String description,
    bool currVal,
    Function updateVal,
  }) {
    return SwitchListTile(
      value: currVal,
      onChanged: updateVal,
      title: Text(title),
      subtitle: Text(description),
    );
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Filters',
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Map<String, bool> _Selectedfilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegetarian,
                };
                widget.setFilter(_Selectedfilters);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection here :',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchTile(
                  title: 'Gluten Free',
                  description: 'Only Include Gluten Free Meals',
                  currVal: _glutenFree,
                  updateVal: (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Lactose Free',
                  description: 'Only Include Lactose Free Meals',
                  currVal: _lactoseFree,
                  updateVal: (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Vegeterian',
                  description: 'Only Include Vegeterian Meals',
                  currVal: _vegetarian,
                  updateVal: (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  },
                ),
                _buildSwitchTile(
                  title: 'Vegan',
                  description: 'Only Include Vegan Meals',
                  currVal: _vegan,
                  updateVal: (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
