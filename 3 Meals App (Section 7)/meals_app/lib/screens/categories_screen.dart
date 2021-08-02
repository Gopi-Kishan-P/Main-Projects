import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/category-screen';
  CategoriesScreen();
  @override
  Widget build(BuildContext context) {
    
    return GridView(
        padding: EdgeInsets.all(18),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map(
              (data) => CategoryItem(
                color: data.color,
                title: data.title,
                id: data.id
              ),
            )
            .toList(),
      );
  }
}
