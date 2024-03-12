import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';
import 'package:the_jokester/widgets/new_joke.dart';

// This screen will both hold user submitted jokes as well as provide bottom sheet to add new jokes
class UserSubmissionScreen extends StatefulWidget {
  const UserSubmissionScreen({super.key});
  static const routeName = '/user-submission';

  @override
  State<UserSubmissionScreen> createState() => _UserSubmissionScreenState();
}

class _UserSubmissionScreenState extends State<UserSubmissionScreen> {
  var userJokes = [];
  @override
  void didChangeDependencies() async {
    userJokes = await DBHelper.retrieveStoredJokes('userJokes');
    setState(() {});
    super.didChangeDependencies();
  }

  void deleteJoke(int id) async {
    await DBHelper.remove('userJokes', {'id': id});
    setState(() {
      userJokes.removeWhere((element) => element['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemBuilder: (context, index) => Dismissible(
            key: userJokes[index]['id'],
            child: ListTile(
              title: userJokes[index]['content'],
            ),
            onDismissed: (direction) {
              deleteJoke(userJokes[index]['id']);
            },
          ),
          itemCount: userJokes.length,
        ),
        IconButton(
          icon: Icon(Icons.add),
          // backgroundColor: Colors.black,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: ((context) => NewJoke()),
            );
          },
        ),
      ],
    );
  }
}
