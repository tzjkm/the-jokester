// Import the foundation package to use the ChangeNotifier class
import 'package:flutter/foundation.dart';

// Import the Joke class from the current directory
import './joke.dart';

// Import the jokes_data file from the parent directory
import '../jokes_data.dart';

// Define a class Jokes that extends ChangeNotifier
class Jokes with ChangeNotifier {
  // Define a private variable _jokes and initialize it with a copy of JOKES_LIST
  List<Joke> _jokes = [...JOKES_LIST];

  // Define a getter for _jokes that returns a copy of _jokes
  List<Joke> get jokes {
    return [..._jokes];
  }

  // Define a method to filter jokes by category
  List<Joke> filterJokesByCategory(String category) {
    // Use the where method to filter _jokes and return a list of jokes in the specified category
    return _jokes.where((j) => j.category == category).toList();
  }
}

// Define a class Categories that extends ChangeNotifier
class Categories with ChangeNotifier {
  // Define a private variable _categories and initialize it with a copy of CATEGORIES_LIST
  final _categories = [...CATEGORIES_LIST];

  // Define a getter for _categories that returns a copy of _categories
  List<Map<String, String>> get categories {
    return [..._categories];
  }
}
