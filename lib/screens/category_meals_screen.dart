import 'package:flutter/material.dart';
import '../models/meal.dart';
import 'package:flutter_learning_2/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

  const CategoryMealsScreen({Key? key, required this.availableMeals})
      : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle = '';
  List<Meal> displayedMeals = [];

  @override
  void didChangeDependencies() {
    final routerArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    categoryTitle = routerArgs['title'] as String;
    final categoryId = routerArgs['id'];

    displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    super.didChangeDependencies();
  }

  // void _removeMeal(String mealIdToDelete) {
  //   setState(() {
  //     displayedMeals.removeWhere((element) => element.id == mealIdToDelete);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final Meal currentMeal = displayedMeals[index];
          return MealItem(
            id: currentMeal.id,
            title: currentMeal.title,
            imageUrl: currentMeal.imageUrl,
            duration: currentMeal.duration,
            complexity: currentMeal.complexity,
            affordability: currentMeal.affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
