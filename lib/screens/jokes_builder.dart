// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import '../providers/jokes.dart';
// // import 'package:the_jokester/screens/joke_detail_screen.dart';

// // //This widget will receive list of jokes and display them
// // // This widget will enable horizontal swiping on different jokes
// // class JokesBuilder extends StatelessWidget {
// //   // final String categoryTitle;
// //   var listOfJokes = [];
// //   final int currentIndex;

// //   JokesBuilder(this.listOfJokes, this.currentIndex);

// //   @override
// //   Widget build(BuildContext context) {
// //     // final filteredJokes =
// //     //     Provider.of<Jokes>(context).filterJokesByCategory(categoryTitle);
// //     final _pageController =
// //         PageController(initialPage: currentIndex); // how was the index stored?
// //     // final jokes = Provider.of<Jokes>(context).jokes;

// //     return PageView.builder(
// //       controller: _pageController,
// //       // itemCount: filter ? filteredJokes.length : jokes.length,
// //       itemCount: listOfJokes.length,
// //       itemBuilder: ((context, index) => JokeDetailScreen(
// //             // filter ? filteredJokes[index].id : jokes[index].id,
// //             listOfJokes[index].id,
// //             // filter ? filteredJokes[index].content : jokes[index].content,
// //             listOfJokes[index].content,
// //           )),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/jokes.dart';
// import '../providers/joke.dart';
// import 'package:the_jokester/screens/joke_detail_screen.dart';

// class JokesBuilder extends StatelessWidget {
//   final List<Joke> listOfJokes;
//   final int currentIndex;

//   JokesBuilder(this.listOfJokes, this.currentIndex);

//   @override
//   Widget build(BuildContext context) {
//     final _pageController = PageController(initialPage: currentIndex);

//     return PageView.builder(
//       controller: _pageController,
//       itemCount: listOfJokes.length,
//       itemBuilder: (context, index) => JokeDetailScreen(
//         listOfJokes[index].id,
//         listOfJokes[index].content,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:the_jokester/screens/joke_detail_screen.dart';
// import '../providers/joke.dart';

// class JokesBuilder extends StatelessWidget {
//   final List<Joke> jokes;
//   final int initialPageIndex;

//   JokesBuilder({
//     required this.jokes,
//     required this.initialPageIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final _pageController = PageController(
//       initialPage: initialPageIndex,
//       viewportFraction: 1.0, // To display one full item at a time
//       keepPage: false, // To avoid keeping unused pages in memory
//     );

//     return PageView.builder(
//       controller: _pageController,
//       itemCount: jokes.length,
//       itemBuilder: (context, index) {
//         final jokeIndex = index % jokes.length; // Calculate circular index
//         return JokeDetailScreen(
//           jokes[jokeIndex].id,
//           jokes[jokeIndex].content,
//         );
//       },
//     );
//   }
// }
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
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.jokes.length,
      itemBuilder: (context, index) {
        final joke = widget.jokes[index];
        return JokeDetailScreen(joke.id, joke.content);
      },
    );
  }

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
