// Import the Flutter Material package for UI design
import 'package:flutter/material.dart';
// Import the DBHelper class for database operations
import '../helpers/db_helper.dart';
// Import the JokeDetailScreen class for displaying the details of a joke
import './joke_detail_screen.dart';

// Define a stateful widget for the Favorites screen
class FavoritesScreen extends StatefulWidget {
  // Constructor for the FavoritesScreen widget
  const FavoritesScreen({Key? key}) : super(key: key);

  // Create the state for the FavoritesScreen widget
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

// Define the state class for the FavoritesScreen widget
class _FavoritesScreenState extends State<FavoritesScreen> {
  // Define a list to hold the favorited jokes
  // Each joke is a map with String keys and values that can be any object
  late List<Map<String, Object?>> favoritedJokes = [];

  // This method runs when the widget is initialized
  @override
  void initState() {
    super.initState();
    // Load the favorited jokes from the database
    _loadFavoritedJokes();
  }

  // Define a method to load the favorited jokes from the database
  Future<void> _loadFavoritedJokes() async {
    // Call the DBHelper method to retrieve the jokes from the 'favoritedJokes' table
    favoritedJokes = await DBHelper.retrieveStoredJokes('favoritedJokes');
    // Call setState to trigger a rebuild of the widget with the updated jokes
    setState(() {}); // Trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritedJokes.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JokeDetailPageView(
                jokes: favoritedJokes,
                initialPage: index,
              ),
            ),
          );
        },
        child: ListTile(
          title: Text(favoritedJokes[index]['content'] as String),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DBHelper.remove('favoritedJokes', favoritedJokes[index]);
              setState(() {
                List<Map<String, Object?>> updatedJokes =
                    List.from(favoritedJokes);
                updatedJokes.removeAt(index);
                favoritedJokes = updatedJokes;
              });
            },
          ),
        ),
      ),
    );
  }
}

class JokeDetailPageView extends StatelessWidget {
  final List<Map<String, Object?>> jokes;
  final int initialPage;

  JokeDetailPageView({required this.jokes, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(initialPage: initialPage),
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        return JokeDetailScreen(
            jokes[index]['id'] as int, jokes[index]['content'] as String);
      },
    );
  }
}
