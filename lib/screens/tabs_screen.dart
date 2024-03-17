import 'package:flutter/material.dart';
import 'package:the_jokester/screens/categories_screen.dart';
import 'package:the_jokester/widgets/main_drawer.dart';
import 'package:the_jokester/screens/favorites_screen.dart';
import 'package:the_jokester/screens/search_screen.dart';
import 'package:the_jokester/screens/user_submission_screen.dart';
import 'package:the_jokester/screens/settings_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<String> _images = [
    'ocean.jpg',
    'tree.jpg',
    'ocean.jpg',
    'ocean.jpg',
    'ocean.jpg',
  ];
  String _backgroundImage = 'ocean.jpg';
  PageController _pageController =
      PageController(initialPage: 0); // Set the initialPage here

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
      'page': SettingsScreen(),
    },
  ];

  @override
  void initState() {
    super.initState();
    // Removed the _pageController.jumpToPage(_selectedPageIndex); line
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _selectedPageIndex = index;
      _backgroundImage = _images[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/$_backgroundImage',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 65, 5, 0),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedPageIndex = index;
                  _backgroundImage = _images[index];
                });
              },
              itemCount: _pages.length,
              itemBuilder: (ctx, index) => AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(child: child, opacity: animation);
                },
                child: _pages[index]['page'],
              ),
            ),
          ),
        ],
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
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Your Jokes',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
