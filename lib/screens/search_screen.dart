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
        child: Center(
          child: Autocomplete<Joke>(
            displayStringForOption: _displayStringForOption,
            optionsBuilder: (textEditingValue) {
              setState(() {
                _inputString = textEditingValue.text;
                var keywords = _inputString!.toLowerCase().split(' ');

                filteredJokes = jokes.where((j) {
                  return keywords.every(
                      (keyword) => j.content.toLowerCase().contains(keyword));
                }).toList();
              });

              if (textEditingValue.text.isEmpty) {
                return Iterable<Joke>.empty();
              }
              return filteredJokes;
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<Joke> onSelected,
                Iterable<Joke> options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4.0,
                  child: SizedBox(
                    height:
                        200.0, // adjust this to change the height of the options container
                    child: ListView.builder(
                      itemCount: options.length,
                      itemBuilder: (context, index) {
                        final option = options.toList()[index];
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(_displayStringForOption(option)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            onSelected: (Joke option) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JokesBuilder(
                  jokes: jokes,
                  initialPageIndex: option.id,
                ),
              ));
            },
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
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
      ),
    );
  }
}
