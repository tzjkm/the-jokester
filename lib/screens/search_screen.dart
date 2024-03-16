import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_jokester/providers/joke.dart';
import 'package:the_jokester/screens/jokes_builder.dart';
import '../providers/jokes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const routeName = '/search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Joke> jokes = [];
  List<Joke> filteredJokes = [];

  @override
  void initState() {
    super.initState();
    jokes = Provider.of<Jokes>(context, listen: false).jokes;
  }

  @override
  Widget build(BuildContext context) {
    String _displayStringForOption(Joke joke) => joke.content;
    String? _inputString;

    return GestureDetector(
      onTap: () {
        print('xdfd');
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: Autocomplete<Joke>(
                displayStringForOption: _displayStringForOption,
                optionsBuilder: (textEditingValue) {
                  setState(() {
                    _inputString = textEditingValue.text;
                    var keywords = _inputString!.toLowerCase().split(' ');

                    filteredJokes = jokes.where((j) {
                      return keywords.every((keyword) =>
                          j.content.toLowerCase().contains(keyword));
                    }).toList();
                  });

                  if (textEditingValue.text.isEmpty) {
                    return Iterable<Joke>.empty();
                  }
                  return filteredJokes;
                },
                onSelected: (Joke option) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JokesBuilder(
                      jokes: jokes,
                      initialPageIndex: option.id,
                    ),
                  ));
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onEditingComplete: onFieldSubmitted,
                    decoration: const InputDecoration(
                      hintText: 'Search here',
                      icon: Icon(Icons.search),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredJokes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(filteredJokes[index].content),
                    // Add any other relevant information about the joke
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
