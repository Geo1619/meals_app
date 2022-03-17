import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';

import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  final List<Meal> availableMeals;

  static const routeName = '/category-meals';

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> categoryMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // Cannot use BuildContext in here!. Too early. use didChangeDependencies() instead.
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'] ?? "";
      final categoryId = routeArgs['id'];
      categoryMeals = widget.availableMeals
          .where(
            (meal) => meal.categories.contains(categoryId),
          )
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((e) => e.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
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
