import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.filters})
      : super(key: key);
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;
  @override
  initState() {
    super.initState();
    _glutenFree = widget.filters['gluten'] ?? false;
    _vegetarian = widget.filters['vegetarian'] ?? false;
    _vegan = widget.filters['vegan'] ?? false;
    _lactoseFree = widget.filters['lactose'] ?? false;
  }

  Widget _buildSwitchListTile(
      {required String title,
      required String subtitle,
      required bool currentValue,
      required Function updateValue}) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(subtitle),
      onChanged: (newValue) => updateValue(newValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(
              Icons.save,
            ),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text('Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6),
        ),
        Expanded(
            child: ListView(
          children: [
            _buildSwitchListTile(
                title: 'Gluten-Free',
                subtitle: 'Only include gluten free meals.',
                currentValue: _glutenFree,
                updateValue: (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
            _buildSwitchListTile(
                title: 'Vegetarian',
                subtitle: 'Only include vegetarian meals.',
                currentValue: _vegetarian,
                updateValue: (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
            _buildSwitchListTile(
                title: 'Vegan',
                subtitle: 'Only include vegan  meals.',
                currentValue: _vegan,
                updateValue: (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
            _buildSwitchListTile(
                title: 'Lactose-Free',
                subtitle: 'Only include lactose free meals.',
                currentValue: _lactoseFree,
                updateValue: (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
          ],
        ))
      ]),
    );
  }
}
