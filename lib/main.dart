import 'package:flutter/material.dart';
import 'package:flutter_learning_2/models/meal.dart';

import 'font_family.dart';
import 'screens/tabs_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';
import 'dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filterValues = {
    'isGlutenFree': false,
    'isVegan': false,
    'isVegetarian': false,
    'isLactoseFree': false,
  };
  List<Meal> _availableMeals = dummyMeals;
  final List<Meal> _favouritedMeals = [];

  void _saveFilters(Map<String, bool> val) {
    setState(() {
      _filterValues = val;
      _availableMeals = dummyMeals.where((element) {
        if (!element.isGlutenFree && _filterValues['isGlutenFree'] as bool) {
          return false;
        }
        if (!element.isLactoseFree && _filterValues['isLactoseFree'] as bool) {
          return false;
        }
        if (!element.isVegan && _filterValues['isVegan'] as bool) {
          return false;
        }
        if (!element.isVegetarian && _filterValues['isVegetarian'] as bool) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final int favMealIndex =
        _favouritedMeals.indexWhere((element) => element.id == mealId);
    if (favMealIndex > -1) {
      setState(() {
        _favouritedMeals.removeAt(favMealIndex);
      });
    } else {
      setState(() {
        _favouritedMeals
            .add(dummyMeals.firstWhere((element) => element.id == mealId));
      });
    }
  }

  bool _isFavourite(String mealId) {
    final isFavourite = _favouritedMeals.any((element) => element.id == mealId);
    return isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(primary: Colors.pink, secondary: Colors.amber),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: FontFamily.raleway,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: const TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.raleway,
                  fontWeight: FontWeight.bold),
            ),
      ),
      routes: {
        '/': (ctx) => TabsScreen(favourites: _favouritedMeals),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetail.routeName: (ctx) => MealDetail(
            toggleFav: _toggleFavourite,
            isFav: _isFavourite,
            availableMeals: _availableMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              filterValues: _filterValues,
              saveFilters: _saveFilters,
            )
      },
    );
  }
}
