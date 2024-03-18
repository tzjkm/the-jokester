// Import the Flutter Material package
import 'package:flutter/material.dart';
// Import the Provider package, which is used for state management
import 'package:provider/provider.dart';
// Import the DBHelper class for database operations
import 'package:the_jokester/helpers/db_helper.dart';
// Import the CategoryJokesScreen class, which displays the jokes for a category
import 'package:the_jokester/screens/category_detail_screen.dart';
// Import the TabsScreen class, which displays the main screen with tabs
import 'package:the_jokester/screens/tabs_screen.dart';
// Import the Jokes class, which holds the state for the jokes
import './providers/jokes.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // Import the Timer class
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper.favoritedJokes =
      await DBHelper.retrieveStoredJokes('favoritedJokes');

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
          initialRoute: '/',
          routes: {
            '/': (context) => LoadingScreen(),
            '/tabsScreen': (context) => TabsScreen(),
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

    // Start the timer
    Timer(Duration(seconds: 5), showRatingDialog);
  }

  void showRatingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rate our app'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  'Please rate our app 5 stars on the Play Store. It helps us a lot.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Maybe Later'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
                const url =
                    'https://play.google.com/store/apps/details?id=com.google.android.apps.maps'; // Replace with your app's URL
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
            ),
          ],
        );
      },
    );
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
