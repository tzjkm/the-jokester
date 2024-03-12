import 'package:flutter/foundation.dart';
import './joke.dart';
import '../jokes_data.dart';

class Jokes with ChangeNotifier {
  List<Joke> _jokes = [...JOKES_LIST];
// List<Joke> _filteredJokes=[...JOKES_LIST];

  List<Joke> get jokes {
    return [..._jokes];
  }

  List<Joke> filterJokesByCategory(String category) {
    return _jokes.where((j) => j.category == category).toList();
  }
}
// class userJokes with ChangeNotifier{

//   retrieveUserJokes
// }

class Categories with ChangeNotifier {
  final _categories = [...CATEGORIES_LIST];
  List<Map<String, String>> get categories {
    return [..._categories];
  }
}
