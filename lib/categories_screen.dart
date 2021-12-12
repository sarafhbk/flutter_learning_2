import 'package:flutter/material.dart';
import 'package:flutter_learning_2/category_item.dart';
import './dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeal'),
      ),
      body: GridView(
          padding: const EdgeInsets.all(25),
          children: dummyCategories
              .map((categ) => CategoryItem(
                  id: categ.id, title: categ.title, color: categ.color))
              .toList(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20)),
    );
  }
}
