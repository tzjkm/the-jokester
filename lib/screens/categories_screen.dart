// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Import the CategoryItem widget from the widgets directory
// This widget is used to display a single category
import 'package:the_jokester/widgets/category_item.dart';

// Import the CATEGORIES_LIST constant from the jokes_data file
// This constant is a list of maps that contains the data for each category
import '../jokes_data.dart';

// Define a StatelessWidget named CategoriesScreen
// StatelessWidget is a widget that describes part of the user interface which can depend on configuration but does not depend on mutable state
class CategoriesScreen extends StatelessWidget {
  // Define a static constant routeName with the value '/categories'
  // This constant is used to identify the route for this screen in the navigation system
  static const routeName = '/categories';

  // Define a constructor for CategoriesScreen that calls the constructor of the superclass with a key
  // The key argument is used by the Flutter framework to identify widgets in the widget tree
  const CategoriesScreen({Key? key}) : super(key: key);

  // Override the build method to return a GridView
  // This method is called when Flutter needs to build the UI of CategoriesScreen
  @override
  Widget build(BuildContext context) {
    return GridView(
        // Create a list of CategoryItem widgets for each category in CATEGORIES_LIST
        children: [
          ...(CATEGORIES_LIST
              .map((c) => CategoryItem(c['title']!, c['imageLoc']!))
              .toList()),
        ],
        // Use a SliverGridDelegateWithMaxCrossAxisExtent to control the layout of the grid
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // Set the maximum extent of items in the cross axis to 200 logical pixels
          maxCrossAxisExtent: 200,
          // Set the spacing between items in the cross axis to 30 logical pixels
          crossAxisSpacing: 30,
          // Set the spacing between items in the main axis to 30 logical pixels
          mainAxisSpacing: 30,
        ));
  }
}
