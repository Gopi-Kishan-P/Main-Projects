import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = 'meal-detail';
  final Function _toggleFavorite;
  final Function _isMealFavorite;
  MealDetailScreen(this._toggleFavorite, this._isMealFavorite);

  Widget headings(String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget listViewBuilder({Widget child, Map routeAgrs}) {
    return Container(
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: routeAgrs['color'], width: 3),
            borderRadius: BorderRadius.circular(18)),
        // width: 300,
        height: 180,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final routeAgrs = ModalRoute.of(context).settings.arguments as Map;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == routeAgrs['id']);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          routeAgrs['title'],
          style: Theme.of(context).textTheme.headline6,
        ),
        backgroundColor: routeAgrs['color'],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Container(
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            headings('Ingredients', context),
            listViewBuilder(
                child: Container(
                  margin: EdgeInsets.all(4),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                      // color: Theme.of(context).accentColor,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(3),
                        child: Text(
                          selectedMeal.ingredients[index],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      elevation: 1,
                    ),
                    itemCount: selectedMeal.ingredients.length,
                  ),
                ),
                routeAgrs: routeAgrs),
            headings('Steps', context),
            listViewBuilder(
                child: ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                          backgroundColor: routeAgrs['color'],
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider()
                    ],
                  ),
                  itemCount: selectedMeal.steps.length,
                ),
                routeAgrs: routeAgrs),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( _isMealFavorite(selectedMeal.id) ? Icons.star : Icons.star_border),
        onPressed: () {
          _toggleFavorite(routeAgrs['id']);
        },
      ),
    );
  }
}
