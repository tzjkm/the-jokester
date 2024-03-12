import 'package:flutter/material.dart';
import 'package:the_jokester/screens/categories_screen.dart';
import 'package:the_jokester/widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';
import 'category_jokes_screen.dart';
import 'search_screen.dart';
import 'user_submission_screen.dart';
import 'customize_screen.dart';

//This screen will be used to control which screen will be displayed above the bottom navigation bar
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  List<Map<String, Object>> _pages = [
    {
      'title': 'Categories',
      'page': CategoriesScreen(),
    },
    {
      'title': 'Favorites',
      'page': FavoritesScreen(),
    },
    {
      'title': 'Search',
      'page': SearchScreen(),
    },
    {
      'title': 'Your jokes',
      'page': UserSubmissionScreen(),
    },
    {
      'title': 'Customize',
      'page': CustomizeScreen(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        actions: [],
        backgroundColor: Color.fromARGB(255, 68, 81, 255),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      drawer: MainDrawer(),
      backgroundColor: Colors.blue[900],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          backgroundColor: Colors.blue[900],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.yellow,
          unselectedLabelStyle: TextStyle(
            color: Colors.yellow,
          ),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: 'Categories',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
              backgroundColor: Colors.lightBlueAccent[700],
              icon: Icon(Icons.star),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_outlined),
              label: 'Your jokes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              label: 'Customize',
            ),
          ]),
    );
  }
}
