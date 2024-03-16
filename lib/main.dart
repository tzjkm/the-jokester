// Import the Flutter Material package
import 'package:flutter/material.dart';
// Import the Provider package, which is used for state management
import 'package:provider/provider.dart';
// Import the DBHelper class for database operations
import 'package:the_jokester/helpers/db_helper.dart';
// Import the CategoryJokesScreen class, which displays the jokes for a category
import 'package:the_jokester/screens/category_jokes_screen.dart';
// Import the TabsScreen class, which displays the main screen with tabs
import 'package:the_jokester/screens/tabs_screen.dart';
// Import the Jokes class, which holds the state for the jokes
import './providers/jokes.dart';
import 'package:flutter/services.dart';

// Define the main function, which is the entry point for the app
void main() async {
  // Ensure that widget binding is initialized
  // This is required because we're running an async operation before runApp
  WidgetsFlutterBinding.ensureInitialized();
  // Retrieve the favorited jokes from the database and assign them to DBHelper.favoritedJokes
  DBHelper.favoritedJokes =
      await DBHelper.retrieveStoredJokes('favoritedJokes');

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Call runApp with an instance of MyApp
  // This starts the app and displays the widget returned by MyApp's build method
  runApp(MyApp());
}

// Define a MyApp class that extends StatelessWidget
// StatelessWidget is a widget that describes part of the user interface which can't change over time
class MyApp extends StatelessWidget {
  // Define a constructor for MyApp that calls the superclass constructor
  const MyApp({super.key});

  // Override the build method to return a widget
  @override
  Widget build(BuildContext context) {
    // Return a MultiProvider, which is a widget that merges multiple providers into one
    return MultiProvider(
      // Provide an instance of Jokes to the widget tree
      providers: [
        ChangeNotifierProvider(create: ((context) => Jokes())),
      ],
      // Define the child of the MultiProvider as a MaterialApp
      child: MaterialApp(
          // Set the title of the app
          title: 'Flutter Demo',
          // Set the theme of the app
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
          ),
          // Set the initial route of the MaterialApp to the LoadingScreen
          initialRoute: '/',
          // Define the routes for the app
          routes: {
            '/': (context) => LoadingScreen(),
            '/tabsScreen': (context) => TabsScreen(),
            // The CategoryDetailScreen route is commented out
            // CategoryDetailScreen.routeName: (context) => CategoryDetailScreen(title),
          }),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/tabsScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/images/download.jpeg'), // replace 'your_image.png' with your image file name
            SizedBox(
                height:
                    20.0), // add some space between the image and the spinner
            CircularProgressIndicator(),
            SizedBox(
                height:
                    20.0), // add some space between the spinner and the text
            Text(
              'The Jokester',
              style: TextStyle(
                  fontSize: 24.0), // adjust the font size to your liking
            ),
          ],
        ),
      ),
    );
  }
}
