import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';
import 'package:the_jokester/widgets/new_joke.dart';

class UserSubmissionScreen extends StatefulWidget {
  const UserSubmissionScreen({required Key key}) : super(key: key);
  static const routeName = '/user-submission';

  @override
  State<UserSubmissionScreen> createState() => _UserSubmissionScreenState();
}

class _UserSubmissionScreenState extends State<UserSubmissionScreen> {
  var userJokes = [];
  final _formKey = GlobalKey<FormState>();
  final _jokeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadJokes();
  }

  Future<void> _loadJokes() async {
    userJokes = await DBHelper.retrieveStoredJokes('userJokes');
    setState(() {});
  }

  Future<void> deleteJoke(int id, int index) async {
    var jokeToDelete = userJokes[index];
    await DBHelper.remove('userJokes', {'id': id});
    _loadJokes();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Joke deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () async {
            await DBHelper.insert('userJokes', jokeToDelete);
            _loadJokes();
          },
        ),
      ),
    );
  }

  void addJoke() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final jokeContent = _jokeController.text;
      await DBHelper.insert('userJokes', {'content': jokeContent});
      _jokeController.clear();
      _loadJokes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Dismissible(
              key: Key(userJokes[index]['id'].toString()),
              child: ListTile(
                title: Text(userJokes[index]['content']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deleteJoke(
                        int.parse(userJokes[index]['id'].toString()), index);
                  },
                ),
              ),
              onDismissed: (direction) {
                deleteJoke(int.parse(userJokes[index]['id'].toString()), index);
              },
            ),
            itemCount: userJokes.length,
          ),
        ),
        Form(
          key: _formKey,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _jokeController,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a joke';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Joke',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: addJoke,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
