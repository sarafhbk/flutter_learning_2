import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Map<String, bool> filterValues;
  final Function(Map<String, bool>) saveFilters;

  const FiltersScreen(
      {Key? key, required this.filterValues, required this.saveFilters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  void initState() {
    final localizedFilterValues = widget.filterValues;
    _isGlutenFree = localizedFilterValues['isGlutenFree'] as bool;
    _isVegan = localizedFilterValues['isVegan'] as bool;
    _isVegetarian = localizedFilterValues['isVegetarian'] as bool;
    _isLactoseFree = localizedFilterValues['isLactoseFree'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(
      bool value, Function(bool) onChanged, String title, String subtitle) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
              onPressed: () {
                widget.saveFilters({
                  'isGlutenFree': _isGlutenFree,
                  'isVegan': _isVegan,
                  'isVegetarian': _isVegetarian,
                  'isLactoseFree': _isLactoseFree,
                });
              },
              icon: const Icon(Icons.save))
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline6,
              )),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(_isGlutenFree, (val) {
                  setState(() {
                    _isGlutenFree = val;
                  });
                }, 'Gluten-free', 'Only include gluten-free meals.'),
                _buildSwitchListTile(_isLactoseFree, (val) {
                  setState(() {
                    _isLactoseFree = val;
                  });
                }, 'Lactose-free', 'Only include lactose-free meals.'),
                _buildSwitchListTile(_isVegan, (val) {
                  setState(() {
                    _isVegan = val;
                  });
                }, 'Vegan', 'Only include vegan meals.'),
                _buildSwitchListTile(_isVegetarian, (val) {
                  setState(() {
                    _isVegetarian = val;
                  });
                }, 'Vegetarian', 'Only include vegetarian meals.')
              ],
            ),
          )
        ],
      ),
    );
  }
}
