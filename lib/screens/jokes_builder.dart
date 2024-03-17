import 'dart:math';
import 'package:flutter/material.dart';
import '../providers/joke.dart';
import 'joke_detail_screen.dart';

class JokesBuilder extends StatefulWidget {
  final List<Joke> jokes;
  final int initialPageIndex;

  JokesBuilder({
    required this.jokes,
    required this.initialPageIndex,
  });

  @override
  _JokesBuilderState createState() => _JokesBuilderState();
}

class _JokesBuilderState extends State<JokesBuilder> {
  late PageController _pageController;
  late int _currentPageIndex;
  final _random = Random();
  late List<Joke> otherJokes;
  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.initialPageIndex;
    _pageController = PageController(initialPage: widget.initialPageIndex);

    _pageController.addListener(() {
      final nextPage = _pageController.page!.round();
      if (nextPage != _currentPageIndex) {
        setState(() {
          _currentPageIndex = nextPage;
        });
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_left),
              Text(" Swipe left or right "),
              Icon(Icons.arrow_right),
            ],
          ),
          duration: Duration(seconds: 3),
        ),
      );
    });
    final initialJoke = widget.jokes[_currentPageIndex % widget.jokes.length];
    otherJokes = List<Joke>.from(widget.jokes)
      ..removeAt(_currentPageIndex)
      ..shuffle();
    otherJokes.insert(0, initialJoke);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        final joke = otherJokes[index % otherJokes.length];
        return JokeDetailScreen(joke.id, joke.content);
      },
    );
  }

  void nextPage() {
    final newIndex = (_currentPageIndex + 1) % widget.jokes.length;
    _pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void previousPage() {
    final newIndex =
        (_currentPageIndex - 1 + widget.jokes.length) % widget.jokes.length;
    _pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
