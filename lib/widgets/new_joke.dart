// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Import the DBHelper helper from the helpers directory
// This helper is used to interact with the SQLite database
import 'package:the_jokester/helpers/db_helper.dart';

// Define a StatefulWidget named NewJoke
// StatefulWidget is a widget that can change over time
class NewJoke extends StatefulWidget {
  // Define a constructor for NewJoke that calls the constructor of the superclass
  // The key parameter is passed to the superclass
  const NewJoke({super.key});

  // Override the createState method to return a new instance of _NewJokeState
  // This method is called when Flutter needs to create the mutable state for this widget
  @override
  State<NewJoke> createState() => _NewJokeState();
}

// Define a State named _NewJokeState that extends the State of NewJoke
// This class holds the mutable state for NewJoke
class _NewJokeState extends State<NewJoke> {
  // Define a TextEditingController named textController
  // This controller is used to read the text and selection state of the TextField
  final textController = TextEditingController();

  // Define a variable userSubmittedJokes of type List
  // This variable is used to store the jokes submitted by the user
  var userSubmittedJokes = [];

  // Override the didChangeDependencies method to retrieve the stored jokes from the database
  // This method is called when a dependency of this State object changes
  @override
  void didChangeDependencies() async {
    // Retrieve the stored jokes from the 'userJokes' table in the database
    userSubmittedJokes = await DBHelper.retrieveStoredJokes('userJokes');

    // Call the didChangeDependencies method of the superclass
    super.didChangeDependencies();
  }

  // Define a method _save that inserts a joke into the 'userJokes' table in the database
  // This method is called when the user submits a joke
  void _save(String id, String content) async {
    // Insert the joke into the 'userJokes' table in the database
    await DBHelper.insert(
        'userJokes', {'id': userSubmittedJokes.length, 'content': content});

    // Update the state to include the new joke
    setState(() {
      userSubmittedJokes
          .add({'id': userSubmittedJokes.length, 'content': 'conten'});
    });
  }

  // Override the build method to return a Container that contains a Column with a Text, a TextField, and a TextButton
  // This method is called when Flutter needs to build the UI of NewJoke
  @override
  Widget build(BuildContext context) {
    // Return a Container
    // Container is a convenience widget that combines common painting, positioning, and sizing widgets
    return Container(
      // The child of the Container is a Column
      // Column is a widget that displays its children in a vertical array
      child: Column(
        children: [
          // The first child of the Column is a Text
          // Text is a widget that displays a short, simple piece of text
          const Text('Enter your joke here'),
          // The second child of the Column is a TextField
          // TextField is a widget that allows the user to enter text
          TextField(
            // Set the controller of the TextField to textController
            controller: textController,
          ),
          // The third child of the Column is a TextButton
          // TextButton is a widget that combines a Text widget with a Button widget
          // The onPressed is not defined
          TextButton(
            onPressed: () {},
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
