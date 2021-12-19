import 'package:flutter/material.dart';
import '../font_family.dart';
import '../models/meal.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';
  final Function toggleFav;
  final List<Meal> availableMeals;
  final Function(String id) isFav;
  const MealDetail(
      {Key? key,
      required this.availableMeals,
      required this.toggleFav,
      required this.isFav})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final Meal selectedMeal =
        availableMeals.firstWhere((meal) => meal.id == mealId);

    Widget renderSubHeading(BuildContext ctx, String text) {
      return Container(
        child: Text(
          text,
          style: Theme.of(ctx).textTheme.headline6,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
      );
    }

    Widget renderListViewContainer(Widget child) {
      return Container(
          width: 300,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black54),
              borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          child: child);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            renderSubHeading(context, 'Ingredients'),
            renderListViewContainer(ListView.builder(
              itemBuilder: (ctx, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Theme.of(context).colorScheme.secondary),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.all(4),
                child: Text(
                  selectedMeal.ingredients[index],
                ),
              ),
              itemCount: selectedMeal.ingredients.length,
            )),
            renderSubHeading(context, 'Steps'),
            renderListViewContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      child: Text(
                        '#${index + 1}',
                      ),
                    ),
                    title: Text(
                      selectedMeal.steps[index],
                      style: const TextStyle(fontFamily: FontFamily.raleway),
                    ),
                  ),
                  const Divider()
                ],
              ),
              itemCount: selectedMeal.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          toggleFav(mealId);
        },
        child: Icon(
          isFav(mealId) as bool ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
