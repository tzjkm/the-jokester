import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';

class JokeDetailScreen extends StatefulWidget {
  final int jokeId;
  final String jokeContent;
  const JokeDetailScreen(this.jokeId, this.jokeContent);

  @override
  State<JokeDetailScreen> createState() => _JokeDetailScreenState();
}

class _JokeDetailScreenState extends State<JokeDetailScreen> {
  var _isFavorite = false;
  var _favoritedJokes = [];
  var isInit = true;
  @override
  void didChangeDependencies() async {
    if (isInit) {
      _favoritedJokes = await DBHelper.retrieveStoredJokes(
        'favoritedJokes',
      );
    }
    if (_favoritedJokes
        .contains({'id': widget.jokeId, 'content': widget.jokeContent})) {
      setState(() {
        _isFavorite = true;
      });
    }

    isInit = false;
    super.didChangeDependencies();
  }

  // void _toggleFavoriteStatus() async {
  //   if (_isFavorite) {
  //     await DBHelper.remove('favoritedJokes',
  //         {'id': widget.jokeId, 'content': widget.jokeContent});
  //     _isFavorite = false;
  //     setState(() {});
  //   } else {
  //     await DBHelper.insert('favoritedJokes',
  //         {'id': widget.jokeId, 'content': widget.jokeContent});
  //     _isFavorite = true;
  //     setState(() {});
  //   }
  // }

  // new function
  void _toggleFavoriteStatus() async {
    setState(() {
      _isFavorite = !_isFavorite; // Toggle favorite status
    });

    if (_isFavorite) {
      await DBHelper.insert('favoritedJokes',
          {'id': widget.jokeId, 'content': widget.jokeContent});
    } else {
      await DBHelper.remove('favoritedJokes', {'id': widget.jokeId});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      persistentFooterButtons: [
        IconButton(
            onPressed: _toggleFavoriteStatus,
            icon: _isFavorite
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline))
      ],
      body: Center(child: Text(widget.jokeContent)),
    );
  }
}
