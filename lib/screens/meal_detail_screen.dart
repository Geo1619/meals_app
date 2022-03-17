import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen(
      {Key? key,
      required this.toggleFavorite,
      required this.isFavorite,
      required})
      : super(key: key);

  // use builder methods for repeated widgets in same screen
  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(ctx).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(
      {required Widget child, required BuildContext context}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width / 1.3,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final mealId = routeArgs['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(title: Text(selectedMeal.title)),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: Image.network(
              selectedMeal.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          buildSectionTitle(context, 'Ingredients'),
          buildContainer(
            context: context,
            child: ListView.builder(
              itemBuilder: ((context, index) => Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  )),
              itemCount: selectedMeal.ingredients.length,
            ),
          ),
          buildSectionTitle(context, 'Steps'),
          buildContainer(
            child: ListView.builder(
              itemBuilder: (context, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(child: Text('# ${index + 1}')),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: selectedMeal.steps.length,
            ),
            context: context,
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: // const Icon(Icons.delete)
            Icon(isFavorite(mealId) ? Icons.favorite : Icons.favorite_border),
        onPressed: () {
          // Navigator.of(context).pop(mealId);
          toggleFavorite(mealId);
        },
      ),
    );
  }
}
