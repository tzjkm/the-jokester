// Import the dart:io package
// This package provides a high-level, idiomatic view of I/O operations in Dart
import 'dart:io';

// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Import the CategoryDetailScreen widget from the screens directory
// This widget is used to display the details of a category
import 'package:the_jokester/screens/category_jokes_screen.dart';

// Define a StatelessWidget named CategoryItem
// StatelessWidget is a widget that describes part of the user interface which can depend on configuration but does not depend on mutable state
class CategoryItem extends StatelessWidget {
  // Define a variable title of type String
  // This variable is used to store the title of the category
  String title;

  // Define a variable imageLoc of type String
  // This variable is used to store the location of the image of the category
  String imageLoc;

  // Define a constructor for CategoryItem that takes title and imageLoc as positional parameters
  // This constructor is used to create a new instance of CategoryItem
  CategoryItem(
    this.title,
    this.imageLoc,
  );

  // Define a method _selectCategory that navigates to a CategoryDetailScreen with the title of the category
  // This method is used to handle the tap event of the InkWell
  // The context parameter is used to access the Navigator for routing
  void _selectCategory(context) {
    // Use the Navigator to push a new route onto the stack
    // MaterialPageRoute is a modal route that replaces the entire screen with a platform-adaptive transition
    Navigator.of(context).push(MaterialPageRoute(
      // The builder returns the widget that will be displayed by the route
      // In this case, it's a CategoryDetailScreen with the title of the category
      builder: (context) => CategoryDetailScreen(title),
    ));
  }

  // Override the build method to return an InkWell that contains a Card with an Image and a Text
  // This method is called when Flutter needs to build the UI of CategoryItem
  @override
  Widget build(BuildContext context) {
    // InkWell is a rectangular area of a Material that responds to touch
    return InkWell(
      // Set the onTap of the InkWell to _selectCategory
      // This is done to navigate to a CategoryDetailScreen when the InkWell is tapped
      onTap: () => _selectCategory(context),
      // The child of the InkWell is a Card
      // Card is a material design card, a panel with slightly rounded corners and an elevation shadow
      child: Card(
        // The child of the Card is a Column
        // Column is a widget that displays its children in a vertical array
        child: Column(children: [
          // The first child of the Column is a Container
          // Container is a convenience widget that combines common painting, positioning, and sizing widgets
          // The Container has a width of 70 and a height of 50
          // The child of the Container is an Image.asset
          // Image.asset creates a widget that displays an image stored as an asset
          // The image asset is specified by imageLoc and the BoxFit is set to contain
          // BoxFit.contain makes the entire image fit within the box while maintaining the aspect ratio of the image
          Container(
            width: 70,
            height: 50,
            child: Image.asset(
              imageLoc,
              fit: BoxFit.contain,
            ),
          ),
          // The second child of the Column is a Text
          // Text is a widget that displays a short, simple piece of text
          // The text is specified by title
          Text(title)
        ]),
      ),
    );
  }
}
