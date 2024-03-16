// Import the Material Design visual design language package
// This package is used to create the UI of the app
import 'package:flutter/material.dart';

// Import the Joke class from the providers directory
// This class is used to model the data of a joke
import '../providers/joke.dart';

// Import the JokeDetailScreen widget from the current directory
// This widget is used to display the details of a joke
import 'joke_detail_screen.dart';

// Define a StatefulWidget named JokesBuilder
// StatefulWidget is a widget that can change over time
class JokesBuilder extends StatefulWidget {
  // Define a final variable jokes of type List<Joke>
  // This variable is used to store the list of jokes that will be displayed
  final List<Joke> jokes;

  // Define a final variable initialPageIndex of type int
  // This variable is used to store the index of the joke that will be displayed first
  final int initialPageIndex;

  // Define a constructor for JokesBuilder that takes jokes and initialPageIndex as required named parameters
  // This constructor is used to create a new instance of JokesBuilder
  JokesBuilder({
    required this.jokes,
    required this.initialPageIndex,
  });

  // Override the createState method to return a new instance of _JokesBuilderState
  // This method is called when Flutter creates a new instance of JokesBuilder
  @override
  _JokesBuilderState createState() => _JokesBuilderState();
}

// Define a private StatefulWidget named _JokesBuilderState that extends the State of JokesBuilder
// This class is used to manage the state of a JokesBuilder
class _JokesBuilderState extends State<JokesBuilder> {
  // Define a late variable _pageController of type PageController
  // This variable is used to control the page view of jokes
  late PageController _pageController;

  // Define a late variable _currentPageIndex of type int
  // This variable is used to store the index of the currently displayed joke
  late int _currentPageIndex;

  // Override the initState method
  // This method is called when Flutter creates a new instance of _JokesBuilderState
  @override
  void initState() {
    super.initState();

    // Initialize _currentPageIndex with the initialPageIndex from the widget
    // This is done to display the joke at initialPageIndex first
    _currentPageIndex = widget.initialPageIndex;

    // Initialize _pageController with a new instance of PageController that has an initialPage of initialPageIndex from the widget
    // This is done to control the page view of jokes
    _pageController = PageController(initialPage: widget.initialPageIndex);

    // Add a listener to _pageController that sets the state of _currentPageIndex to the current page round to the nearest whole number
    // This is done to update _currentPageIndex when the user scrolls to a new joke
    _pageController.addListener(() {
      final nextPage = _pageController.page!.round();
      if (nextPage != _currentPageIndex) {
        setState(() {
          _currentPageIndex = nextPage;
        });
      }
    });
  }

  // Override the build method to return a PageView.builder
  // This method is called when Flutter needs to build the UI of _JokesBuilderState
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // Set the controller of the PageView.builder to _pageController
      // This is done to control the page view of jokes
      controller: _pageController,

      // Set the itemCount of the PageView.builder to the length of jokes from the widget
      // This is done to tell the PageView.builder how many jokes there are
      itemCount: widget.jokes.length,

      // Define the itemBuilder of the PageView.builder to return a JokeDetailScreen with the id and content of the joke at the current index
      // This is done to build the UI of each joke
      itemBuilder: (context, index) {
        final joke = widget.jokes[index];
        return JokeDetailScreen(joke.id, joke.content);
      },
    );
  }

  // Define a method nextPage that animates to the next page or the first page if the current page is the last page
  // This method is used to navigate to the next joke
  void nextPage() {
    final newIndex = _currentPageIndex == widget.jokes.length - 1
        ? 0
        : _currentPageIndex + 1;
    _pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Define a method previousPage that animates to the previous page or the last page if the current page is the first page
  // This method is used to navigate to the previous joke
  void previousPage() {
    final newIndex = _currentPageIndex == 0
        ? widget.jokes.length - 1
        : _currentPageIndex - 1;
    _pageController.animateToPage(
      newIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
