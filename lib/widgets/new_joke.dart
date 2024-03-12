import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';

class NewJoke extends StatefulWidget {
  const NewJoke({super.key});

  @override
  State<NewJoke> createState() => _NewJokeState();
}

class _NewJokeState extends State<NewJoke> {
  final textController = TextEditingController();

  var userSubmittedJokes = [];
  @override
  void didChangeDependencies() async {
    userSubmittedJokes = await DBHelper.retrieveStoredJokes('userJokes');

    super.didChangeDependencies();
  }

  void _save(String id, String content) async {
    await DBHelper.insert(
        'userJokes', {'id': userSubmittedJokes.length, 'content': content});
    setState(() {
      userSubmittedJokes
          .add({'id': userSubmittedJokes.length, 'content': 'conten'});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text('Enter your joke here'),
          TextField(
            controller: textController,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Save'),
          )
        ],
      ),
    );
  }
}
