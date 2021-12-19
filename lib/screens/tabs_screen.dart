import 'package:flutter/material.dart';
import 'package:flutter_learning_2/widgets/main_drawer.dart';
import '../screens/categories_screen.dart';
import '../screens/favourites_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favourites;
  const TabsScreen({Key? key, required this.favourites}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>> _pages = [];

  int _selectedTabIndex = 0;

  @override
  void initState() {
    _pages = [
      {'screen': const CategoriesScreen(), 'title': 'Categories'},
      {
        'screen': FavouritesScreen(favs: widget.favourites),
        'title': 'Favourites'
      },
    ];
    super.initState();
  }

  void _onTabPress(index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(_pages[_selectedTabIndex]['title']),
      ),
      body: _pages[_selectedTabIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          onTap: _onTabPress,
          currentIndex: _selectedTabIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: 'Favourites'),
          ]),
    );
  }
}
