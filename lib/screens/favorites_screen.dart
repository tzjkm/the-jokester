// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import '../helpers/db_helper.dart';

// class FavoritesScreen extends StatefulWidget {
//   const FavoritesScreen({super.key});

//   @override
//   State<FavoritesScreen> createState() => _FavoritesScreenState();
// }

// class _FavoritesScreenState extends State<FavoritesScreen> {
//   var favoritedJokes = [];
//   @override
//   void didChangeDependencies() async {
//     favoritedJokes = await DBHelper.retrieveStoredJokes('favoritedJokes');

//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: favoritedJokes.length,
//       itemBuilder: (context, index) => ListTile(
//           title: Text(favoritedJokes[index]['content']),
//           trailing: IconButton(
//             icon: Icon(Icons.favorite),
//             onPressed: null,
//           )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../helpers/db_helper.dart';

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
    return ListView.builder(
      itemCount: favoritedJokes.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(favoritedJokes[index]['content'] as String),
        // Add functionality to remove the joke from favorites if needed
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () async {
            await DBHelper.remove('favoritedJokes', favoritedJokes[index]);
            setState(() {
              favoritedJokes.removeAt(index);
            });
          },
        ),
      ),
    );
  }
}
