import 'package:flutter/material.dart';
import 'package:the_jokester/screens/categories_screen.dart';
import 'package:the_jokester/widgets/main_drawer.dart';
import 'package:the_jokester/screens/favorites_screen.dart';
import 'package:the_jokester/screens/search_screen.dart';
import 'package:the_jokester/screens/user_submission_screen.dart';
import 'package:the_jokester/screens/customize_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
  ];
  Color _backgroundColor = Colors.red;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _backgroundColor = _colors[index];
    });
  }

  final List<Map<String, dynamic>> _pages = [
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
      'page': UserSubmissionScreen(key: ValueKey('UserSubmissionScreen')),
    },
    {
      'title': 'Customize',
      'page': CustomizeScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        color: _backgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 65, 5, 0),
          child: IndexedStack(
            index: _selectedPageIndex,
            children:
                _pages.map<Widget>((page) => page['page'] as Widget).toList(),
          ),
        ),
      ),
      drawer: const MainDrawer(),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          child: Icon(Icons.menu),
          backgroundColor: Colors.black.withOpacity(0.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.yellow,
        unselectedLabelStyle: const TextStyle(
          color: Colors.yellow,
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: 'Categories',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.black,
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
        ],
      ),
    );
  }
}
