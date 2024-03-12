import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_jokester/helpers/db_helper.dart';
import 'package:the_jokester/screens/category_jokes_screen.dart';
import 'package:the_jokester/screens/tabs_screen.dart';
import './providers/jokes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.favoritedJokes =
      await DBHelper.retrieveStoredJokes('favoritedJokes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Jokes())),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          home: TabsScreen(),
          routes: {
            // CategoryDetailScreen.routeName: (context) => CategoryDetailScreen(title),
          }),
    );
  }
}
