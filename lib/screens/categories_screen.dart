import 'package:flutter/material.dart';
import 'package:the_jokester/widgets/category_item.dart';
import '../jokes_data.dart';
import 'package:the_jokester/widgets/main_drawer.dart'; // Import MainDrawer

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(), // Add MainDrawer button
      body: Column(
        children: [
          SafeArea(
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: GridView(
              children: [
                ...(CATEGORIES_LIST
                    .map((c) => CategoryItem(c['title']!, c['imageLoc']!))
                    .toList()),
              ],
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
