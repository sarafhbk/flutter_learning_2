import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routerArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final categoryTitle = routerArgs['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle as String),
      ),
      body: const Center(
        child: Text('Hello'),
      ),
    );
  }
}
