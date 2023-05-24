import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  String _activePageTitle = 'Categories';

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
      _activePageTitle = 'Favorites';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const CategoriesScreen();

    if (_selectedPageIndex == 1) {
      activePage = const MealsScreen(
        meals: [],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('dynamic...'),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
