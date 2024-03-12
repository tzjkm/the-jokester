import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_jokester/providers/joke.dart';
import 'package:the_jokester/screens/jokes_builder.dart';
import '../providers/jokes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = '/search';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Joke> jokes = Provider.of<Jokes>(context, listen: false).jokes;

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
        child: Row(children: [
          Expanded(
            child: Autocomplete<Joke>(
              displayStringForOption: _displayStringForOption,
              optionsBuilder: ((textEditingValue) {
                setState(() {
                  _inputString = textEditingValue.text;
                });
                if (textEditingValue.text == '') {
                  return Iterable<Joke>.empty();
                }
                return jokes.where((j) {
                  return j.content.contains(textEditingValue.text);
                }).toList();
              }),
              onSelected: (Joke option) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => JokesBuilder(
                          jokes: jokes,
                          initialPageIndex: option.id,
                        ))));
              },
              // initialValue: TextEditingValue(selection: ),
              fieldViewBuilder: ((context, textEditingController, focusNode,
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
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
