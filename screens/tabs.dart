import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  String _activePageTitle = 'Categories';

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'filters') {
      await Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (context) {
        return const FiltersScreen();
      }));
    }
  }

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
      _activePageTitle = _selectedPageIndex == 0 ? 'Categories' : 'Favorites';
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );

    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_activePageTitle),
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
      // drawer: MainDrawer(onSelectScreen: _setScreen),
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  showDragHandle: true,
                  context: context,
                  builder: (context) => const FiltersScreen(),
                );
              },
              child: const Icon(Icons.filter_list),
            )
          : null,
    );
  }
}
