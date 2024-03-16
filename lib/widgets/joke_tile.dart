// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Import the DBHelper helper from the helpers directory
// This helper is used to interact with the SQLite database
import 'package:the_jokester/helpers/db_helper.dart';

// Import the JokesBuilder screen from the screens directory
// This screen is used to display a list of jokes
import 'package:the_jokester/screens/jokes_builder.dart';

// Import the JokeDetailScreen from the screens directory
// This screen is used to display the details of a joke
import '../screens/joke_detail_screen.dart';

// Import the Jokes provider from the providers directory
// This provider is used to manage the state of the jokes
import '../providers/jokes.dart';

// Import the Provider package
// This package is used for state management
import 'package:provider/provider.dart';

// Define a StatefulWidget named JokeTile
// StatefulWidget is a widget that can change over time
class JokeTile extends StatefulWidget {
  // Define a variable jokeId of type int
  // This variable is used to store the id of the joke
  final int jokeId;

  // Define a variable jokeContent of type String
  // This variable is used to store the content of the joke
  final String jokeContent;

  // Define a variable categoryTitle of type String
  // This variable is used to store the title of the category
  final String categoryTitle;

  // Define a variable currentIndex of type int
  // This variable is used to store the current index of the joke in the list
  final int currentIndex;

  // Define a constructor for JokeTile that takes jokeId, categoryTitle, jokeContent, and currentIndex as positional parameters
  // This constructor is used to create a new instance of JokeTile
  const JokeTile(
    this.jokeId,
    this.categoryTitle,
    this.jokeContent,
    this.currentIndex,
  );

  // Override the createState method to return a new instance of _JokeTileState
  // This method is called when Flutter needs to create the mutable state for this widget
  @override
  State<JokeTile> createState() => _JokeTileState();
}

// Define a State named _JokeTileState that extends the State of JokeTile
// This class holds the mutable state for JokeTile
class _JokeTileState extends State<JokeTile> {
  // Override the build method to return a ListTile that contains a Text and an IconButton
  // This method is called when Flutter needs to build the UI of JokeTile
  @override
  Widget build(BuildContext context) {
    // Get the list of jokes from the Jokes provider
    final jokes = Provider.of<Jokes>(context, listen: false).jokes;

    // Get the list of jokes filtered by category from the Jokes provider
    final filteredJokes = Provider.of<Jokes>(context, listen: false)
        .filterJokesByCategory(widget.categoryTitle);

    // Return a ListTile
    // ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon
    return ListTile(
      // Set the title of the ListTile to a Text widget that displays the content of the joke
      // The text is centered and clipped if it overflows
      title: Text(
        widget.jokeContent,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
      ),
      // Set the onTap of the ListTile to navigate to a JokesBuilder when the ListTile is tapped
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return JokesBuilder(
              jokes: jokes,
              initialPageIndex: widget.currentIndex,
            );
          },
        ));
      },
      // The trailing widget is commented out
      // It's an IconButton that displays a favorite outline icon
      // The onPressed is not defined
      // trailing: IconButton(
      //   icon: Icon(Icons.favorite_outline, color: Colors.black),
      //   onPressed: ,
      // ),
    );
  }
}
