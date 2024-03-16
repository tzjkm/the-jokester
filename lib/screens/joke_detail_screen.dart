// Import the Flutter Material package
import 'package:flutter/material.dart';
// Import the DBHelper class for database operations
import 'package:the_jokester/helpers/db_helper.dart';

// Define a JokeDetailScreen class that extends StatefulWidget
// StatefulWidget is a widget that can change over time
class JokeDetailScreen extends StatefulWidget {
  // Define a final variable for the joke ID
  final int jokeId;
  // Define a final variable for the joke content
  final String jokeContent;
  // Define a constructor for the JokeDetailScreen class
  const JokeDetailScreen(this.jokeId, this.jokeContent);

  // Override the createState method to return a new instance of _JokeDetailScreenState
  @override
  State<JokeDetailScreen> createState() => _JokeDetailScreenState();
}

// Define a _JokeDetailScreenState class that extends State
// This class holds the mutable state for this widget
class _JokeDetailScreenState extends State<JokeDetailScreen> {
  // Define a variable to hold whether the joke is a favorite
  var _isFavorite = false;
  // Define a list to hold the favorited jokes
  var _favoritedJokes = [];
  // Define a boolean to check if it's the first time the widget is being built
  var isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      _favoritedJokes = await DBHelper.retrieveStoredJokes('favoritedJokes');
    }

    // Check if the joke is in the favorites list
    for (var joke in _favoritedJokes) {
      if (joke['id'] == widget.jokeId &&
          joke['content'] == widget.jokeContent) {
        setState(() {
          _isFavorite = true;
        });
        break;
      }
    }

    isInit = false;
    super.didChangeDependencies();
  }

  // Define a method to toggle the favorite status of the joke
  void _toggleFavoriteStatus() async {
    // If the joke is a favorite
    if (_isFavorite) {
      // Remove the joke from the favorites in the database
      await DBHelper.remove('favoritedJokes',
          {'id': widget.jokeId, 'content': widget.jokeContent});
      // Set _isFavorite to false
      _isFavorite = false;
      // Update the UI
      setState(() {});
    } else {
      // Otherwise, add the joke to the favorites in the database
      await DBHelper.insert('favoritedJokes',
          {'id': widget.jokeId, 'content': widget.jokeContent});
      // Set _isFavorite to true
      _isFavorite = true;
      // Update the UI
      setState(() {});
    }
  }

  // Override the build method to describe the part of the user interface this widget represents
  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget, which provides a framework for major Material Components
    return Scaffold(
      // Add a floating action button that pops the current route
      floatingActionButton: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      // Set the location of the floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      // Add a persistent footer button that toggles the favorite status of the joke
      persistentFooterButtons: [
        IconButton(
            onPressed: _toggleFavoriteStatus,
            icon: _isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline))
      ],
      // Set the body of the scaffold to a Center widget that contains the joke content
      body: Center(child: Text(widget.jokeContent)),
    );
  }
}
