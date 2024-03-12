import 'providers/joke.dart';

final CATEGORIES_LIST = [
  // This will be used to generate the tiles in grid view categories overview
  {
    'title': 'cat1',
    'imageLoc': 'assets/images/download.jpeg',
  },
  {
    'title': 'cat2',
    'imageLoc': 'assets/images/download.jpeg',
  },
  {
    'title': 'cat3',
    'imageLoc': 'assets/images/download.jpeg',
  }
];

final JOKES_LIST = [
  Joke(
    id: 0,
    category: 'cat1',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ',
  ),
  Joke(
    id: 1,
    category: 'cat1',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ',
  ),
  Joke(
    id: 2,
    category: 'cat1',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 1 2',
  ),
  Joke(
    id: 3,
    category: 'cat1',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 3 ',
  ),
  Joke(
    id: 4,
    category: 'cat2',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 2 1',
  ),
  Joke(
    id: 5,
    category: 'cat3',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 1',
  ),
  Joke(
    id: 6,
    category: 'cat3',
    content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 2',
  ),
];
