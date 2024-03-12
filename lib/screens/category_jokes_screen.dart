// import 'package:flutter/material.dart';
// import 'package:the_jokester/widgets/joke_tile.dart';
// import 'package:provider/provider.dart';
// import '../providers/jokes.dart';
// //This widget will hold jokes for a particular category

// class CategoryDetailScreen extends StatefulWidget {
//   final String categoryTitle;

//   const CategoryDetailScreen(this.categoryTitle);
//   static const routeName = '/category-detail';

//   @override
//   State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
// }

// class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final filteredJokes = Provider.of<Jokes>(context, listen: false)
//         .filterJokesByCategory(widget.categoryTitle);

//     return Scaffold(
//       floatingActionButton: IconButton(
//         icon: Icon(Icons.arrow_back_rounded),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
//       body: ListView.builder(
//           itemCount: filteredJokes.length,
//           itemBuilder: ((context, index) => JokeTile(
//                 filteredJokes[index].id,
//                 widget.categoryTitle,
//                 filteredJokes[index].content,
//                 index,
//               ))),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:the_jokester/widgets/joke_tile.dart';
// import 'package:provider/provider.dart';
// import '../providers/jokes.dart';

// class CategoryDetailScreen extends StatelessWidget {
//   final String categoryTitle;

//   const CategoryDetailScreen(this.categoryTitle);

//   @override
//   Widget build(BuildContext context) {
//     final filteredJokes =
//         Provider.of<Jokes>(context).filterJokesByCategory(categoryTitle);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryTitle),
//       ),
//       body: ListView.builder(
//         itemCount: filteredJokes.length,
//         itemBuilder: (context, index) => JokeTile(
//           filteredJokes[index].id,
//           categoryTitle,
//           filteredJokes[index].content,
//           index,
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:the_jokester/screens/jokes_builder.dart';
// import 'package:provider/provider.dart';
// import '../providers/jokes.dart';

// class CategoryDetailScreen extends StatefulWidget {
//   final String categoryTitle;

//   const CategoryDetailScreen(this.categoryTitle);
//   static const routeName = '/category-detail';

//   @override
//   State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
// }

// class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final jokesProvider = Provider.of<Jokes>(context, listen: false);
//     final filteredJokes =
//         jokesProvider.filterJokesByCategory(widget.categoryTitle);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.categoryTitle),
//       ),
//       body: JokesBuilder(
//         jokes: filteredJokes,
//         initialPageIndex: 0, // You can set initial page index here
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_jokester/screens/jokes_builder.dart';
import 'package:provider/provider.dart';
import '../providers/jokes.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryTitle;

  const CategoryDetailScreen(this.categoryTitle);
  static const routeName = '/category-detail';

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  int _randomJokeIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectRandomJokeIndex();
  }

  void _selectRandomJokeIndex() {
    final jokesProvider = Provider.of<Jokes>(context, listen: false);
    final filteredJokes =
        jokesProvider.filterJokesByCategory(widget.categoryTitle);
    if (filteredJokes.isNotEmpty) {
      final randomIndex = Random().nextInt(filteredJokes.length);
      setState(() {
        _randomJokeIndex = randomIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final jokesProvider = Provider.of<Jokes>(context, listen: false);
    final filteredJokes =
        jokesProvider.filterJokesByCategory(widget.categoryTitle);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
      ),
      body: filteredJokes.isEmpty
          ? Center(
              child: Text('No jokes available in this category'),
            )
          : JokesBuilder(
              jokes: filteredJokes,
              initialPageIndex: _randomJokeIndex,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectRandomJokeIndex,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
