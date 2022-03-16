import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatelessWidget {
  const CategoryMealsScreen({Key? key}) : super(key: key);
  // const CategoryMealsScreen(
  //     {Key? key, required this.categoryId, required this.categoryTitle})
  //     : super(key: key);

  // final String categoryId;
  // final String categoryTitle;
  static const routeName = '/category-meals';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where(
          (element) => element.categories.contains(categoryId),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          var meal = categoryMeals[index];
          return MealItem(
            id: meal.id,
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
