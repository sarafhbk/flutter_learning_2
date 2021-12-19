import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favs;
  const FavouritesScreen({Key? key, required this.favs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favs.isEmpty) {
      return const Center(
        child: Text('No favourites added.'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          final Meal currentMeal = favs[index];
          return MealItem(
            id: currentMeal.id,
            title: currentMeal.title,
            imageUrl: currentMeal.imageUrl,
            duration: currentMeal.duration,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
          );
        },
        itemCount: favs.length,
      );
    }
  }
}
