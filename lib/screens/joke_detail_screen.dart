import 'package:flutter/material.dart';
import 'package:the_jokester/helpers/db_helper.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class JokeDetailScreen extends StatefulWidget {
  final int jokeId;
  final String jokeContent;
  const JokeDetailScreen(this.jokeId, this.jokeContent);

  @override
  State<JokeDetailScreen> createState() => _JokeDetailScreenState();
}

class _JokeDetailScreenState extends State<JokeDetailScreen> {
  var _isFavorite = false;
  var _favoritedJokes = [];
  var isInit = true;

  final List<String> _imageNames = [
    'ocean.jpg',
    'ocean.jpg',
    'ocean.jpg',
    'ocean.jpg',
    'ocean.jpg',
  ];

  late String _selectedImage;

  @override
  void initState() {
    super.initState();
    _selectedImage = _imageNames[Random().nextInt(_imageNames.length)];
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      _favoritedJokes = await DBHelper.retrieveStoredJokes('favoritedJokes');
    }

    for (var joke in _favoritedJokes) {
      if (joke['id'] == widget.jokeId &&
          joke['content'] == widget.jokeContent) {
        setState(() {
          _isFavorite = true;
        });
        break;
      }
    }

    isInit = false;
    super.didChangeDependencies();
  }

  void _toggleFavoriteStatus() async {
    if (_isFavorite) {
      await DBHelper.remove('favoritedJokes',
          {'id': widget.jokeId, 'content': widget.jokeContent});
      _isFavorite = false;
      setState(() {});
    } else {
      await DBHelper.insert('favoritedJokes',
          {'id': widget.jokeId, 'content': widget.jokeContent});
      _isFavorite = true;
      setState(() {});
    }
  }

  void _shareJoke() async {
    var whatsappUrl = "whatsapp://send?text=${Uri.parse(widget.jokeContent)}";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/$_selectedImage',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.black54,
              child: Text(
                widget.jokeContent,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 30,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            right: 10,
            bottom: 30,
            child: Row(
              children: [
                IconButton(
                  icon: _isFavorite
                      ? Icon(Icons.favorite, color: Colors.red)
                      : Icon(Icons.favorite_outline, color: Colors.white),
                  onPressed: _toggleFavoriteStatus,
                ),
                IconButton(
                  icon: Icon(Icons.share, color: Colors.white),
                  onPressed: _shareJoke,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
