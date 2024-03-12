import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';
import 'package:the_jokester/screens/jokes_builder.dart';
import '../screens/joke_detail_screen.dart';
import '../providers/jokes.dart';
import 'package:provider/provider.dart';

class JokeTile extends StatefulWidget {
  final int jokeId;
  final String jokeContent;
  final String categoryTitle;
  final int currentIndex;
  const JokeTile(
    this.jokeId,
    this.categoryTitle,
    this.jokeContent,
    this.currentIndex,
  );

  @override
  State<JokeTile> createState() => _JokeTileState();
}

class _JokeTileState extends State<JokeTile> {
  @override
  Widget build(BuildContext context) {
    final jokes = Provider.of<Jokes>(context, listen: false).jokes;
    final filteredJokes = Provider.of<Jokes>(context, listen: false)
        .filterJokesByCategory(widget.categoryTitle);

    return ListTile(
      title: Text(
        widget.jokeContent,
        overflow: TextOverflow.clip,
        textAlign: TextAlign.center,
      ),
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
      // trailing: IconButton(
      //   icon: Icon(Icons.favorite_outline, color: Colors.black),
      //   onPressed: ,
      // ),
    );
  }
}
