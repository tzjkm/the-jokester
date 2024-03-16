// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Define a StatefulWidget named SearchBar
// StatefulWidget is a widget that can change over time
class SearchBar extends StatefulWidget {
  // Define a constructor for SearchBar that calls the constructor of the superclass
  // The key parameter is passed to the superclass
  const SearchBar({super.key});

  // Override the createState method to return a new instance of _SearchBarState
  // This method is called when Flutter needs to create the mutable state for this widget
  @override
  State<SearchBar> createState() => _SearchBarState();
}

// Define a State named _SearchBarState that extends the State of SearchBar
// This class holds the mutable state for SearchBar
class _SearchBarState extends State<SearchBar> {
  // Override the build method to return a Container
  // This method is called when Flutter needs to build the UI of SearchBar
  @override
  Widget build(BuildContext context) {
    // Return a Container
    // Container is a convenience widget that combines common painting, positioning, and sizing widgets
    return Container();
  }
}
