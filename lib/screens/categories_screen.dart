import 'package:flutter/material.dart';
import 'package:the_jokester/widgets/category_item.dart';
import '../jokes_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
        children: [
          ...(CATEGORIES_LIST
              .map((c) => CategoryItem(c['title']!, c['imageLoc']!))
              .toList()),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ));
  }
}
