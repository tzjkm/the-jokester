// Import the Cupertino package
import 'package:flutter/cupertino.dart';
// Import the Material package
import 'package:flutter/material.dart';
// Import the DBHelper class from the helpers directory
import 'package:the_jokester/helpers/db_helper.dart';
// Import the NewJoke widget from the widgets directory
import 'package:the_jokester/widgets/new_joke.dart';

// Define a StatefulWidget. This is a widget that can change over time.
class UserSubmissionScreen extends StatefulWidget {
  // Constructor for UserSubmissionScreen
  const UserSubmissionScreen({required Key key}) : super(key: key);
  // Define a static constant for the route name
  static const routeName = '/user-submission';

  // Create the state for this widget
  @override
  State<UserSubmissionScreen> createState() => _UserSubmissionScreenState();
}

// Define the state for UserSubmissionScreen
class _UserSubmissionScreenState extends State<UserSubmissionScreen> {
  // Define a variable to hold the user's jokes
  var userJokes = [];
  // Define a GlobalKey to identify the Form widget
  final _formKey = GlobalKey<FormState>();
  // Define a TextEditingController to control the text field
  final _jokeController = TextEditingController();

  // Override the didChangeDependencies method
  @override
  void didChangeDependencies() async {
    // Retrieve the user's jokes from the database
    userJokes = await DBHelper.retrieveStoredJokes('userJokes');
    // Update the state to reflect the new jokes
    setState(() {});
    // Call the superclass's didChangeDependencies method
    super.didChangeDependencies();
  }

  // Define a method to delete a joke
  void deleteJoke(int id) async {
    // Remove the joke from the database
    await DBHelper.remove('userJokes', {'id': id});
    // Update the state to reflect the deleted joke
    setState(() {
      userJokes.removeWhere((element) => element['id'] == id);
    });
  }

  // Define a method to add a joke
  void addJoke() async {
    // Validate the form
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Get the joke content from the text field
      final jokeContent = _jokeController.text;
      // Save the joke to the database
      await DBHelper.insert('userJokes', {'content': jokeContent});
      // Clear the text field
      _jokeController.clear();
      // Refresh the joke list
      userJokes = await DBHelper.retrieveStoredJokes('userJokes');
      // Update the state to reflect the new joke
      setState(() {});
    }
  }

  // Override the build method to return a widget
  @override
  Widget build(BuildContext context) {
    // Return a Column widget
    return Column(
      children: [
        // Create a ListView.builder to display the jokes
        // ListView.builder is a widget which can be used when we have a dynamic list
        // 'Expanded' widget is used to make the ListView take all the available space
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Dismissible(
              // Each Dismissible instance must contain a Key. Keys allow Flutter to uniquely identify widgets.
              key: Key(userJokes[index]['id'].toString()),
              // ListTile is a single fixed-height row that typically contains some text as well as a leading or trailing icon.
              child: ListTile(
                title: Text(userJokes[index]['content']),
              ),
              // The direction in which the dismissible can be dismissed.
              onDismissed: (direction) {
                // Function to delete a joke when the Dismissible is dismissed
                deleteJoke(userJokes[index]['id']);
              },
            ),
            // The number of items in the list.
            itemCount: userJokes.length,
          ),
        ),
        // Create a Form to add new jokes
        // Form is a widget that contains FormField
        Form(
          // GlobalKey is used here to identify the Form and validate it
          key: _formKey,
          child: Row(
            children: [
              // Create a TextFormField for joke input
              // TextFormField is a FormField that contains a TextField.
              Expanded(
                child: TextFormField(
                  // The controller can be used to control the text that appears in the text field.
                  controller: _jokeController,
                  // Validator gets called with the current text in the text field.
                  // If the text is valid, it should return null. If the text is invalid, it should return a string with an error message.
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a joke';
                    }
                    return null;
                  },
                  // Used to define the appearance of the text field.
                  decoration: InputDecoration(
                    labelText: 'New Joke',
                  ),
                ),
              ),
              // Create an IconButton to submit the joke
              // IconButton is a picture printed on a Material widget that reacts to touches by filling with color.
              IconButton(
                icon: Icon(Icons.add),
                // Function to be called when the button is tapped.
                onPressed: addJoke,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
