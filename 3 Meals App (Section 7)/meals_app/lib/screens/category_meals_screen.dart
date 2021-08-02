import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';


class CategoryMealScreen extends StatefulWidget {
  static const String catscreeen = '/category-meal-screen';

  List<Meal> availableMeal;

  CategoryMealScreen(this.availableMeal);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  Map routeArgs;
  bool isChanged = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isChanged) {
      routeArgs = ModalRoute.of(context).settings.arguments as Map;
      final categoryId = routeArgs['id'];
      final categoryTitle = routeArgs['title'];
      displayMeals = widget.availableMeal
          .where((meal) => meal.categories.contains(categoryId))
          .toList();
      isChanged = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String mealId) {
    setState(() {
      displayMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            routeArgs['title'],
            style: Theme.of(context).textTheme.headline6,
          ),
          backgroundColor: routeArgs['color'],
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: displayMeals[index].title,
              id: displayMeals[index].id,
              color: routeArgs['color'],
              imageUrl: displayMeals[index].imageUrl,
              duration: displayMeals[index].duration,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
              removeItem: _removeItem,
            );
          },
          itemCount: displayMeals.length,
        ),
      ),
    );
  }
}
