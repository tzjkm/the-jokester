import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';
import './joke_detail_screen.dart';
import 'package:the_jokester/widgets/main_drawer.dart'; // Import MainDrawer

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Map<String, Object?>> favoritedJokes = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritedJokes();
  }

  Future<void> _loadFavoritedJokes() async {
    favoritedJokes = await DBHelper.retrieveStoredJokes('favoritedJokes');
    setState(() {}); // Trigger rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(), // Add MainDrawer button
      body: Column(
        children: [
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(width: 50), // To balance the IconButton size
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                      await DBHelper.remove(
                          'favoritedJokes', favoritedJokes[index]);
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
            ),
          ),
        ],
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
