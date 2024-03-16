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
      body: filteredJokes.isEmpty
          ? Center(
              child: Text('No jokes available in this category'),
            )
          : JokesBuilder(
              jokes: filteredJokes,
              initialPageIndex: _randomJokeIndex,
            ),
    );
  }
}
