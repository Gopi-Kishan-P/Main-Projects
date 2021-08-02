import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {

  List<Meal> favoriteMeal;
  FavoriteScreen(this.favoriteMeal);

  @override
  Widget build(BuildContext context) {

    return favoriteMeal.isEmpty ? Center(
      child: Text('You Don\'t have any Favorites. Add One'),
    ):
    ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              title: favoriteMeal[index].title,
              id: favoriteMeal[index].id,
              imageUrl: favoriteMeal[index].imageUrl,
              duration: favoriteMeal[index].duration,
              complexity: favoriteMeal[index].complexity,
              affordability: favoriteMeal[index].affordability,
              color: Color(0xff7e60c2),
            );
          },
          itemCount: favoriteMeal.length,
        )
    ;
  }
}