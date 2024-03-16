// Import the Joke class from the providers directory
import 'providers/joke.dart';

// Define a constant list of categories. Each category is a map with a title and an image location.
// This list will be used to generate the tiles in the grid view categories overview.
final CATEGORIES_LIST = [
  {
    'title': 'cat1', // The title of the first category
    'imageLoc':
        'assets/images/download.jpeg', // The image location of the first category
  },
  {
    'title': 'cat2', // The title of the second category
    'imageLoc':
        'assets/images/download.jpeg', // The image location of the second category
  },
  {
    'title': 'cat3', // The title of the third category
    'imageLoc':
        'assets/images/download.jpeg', // The image location of the third category
  }
];

// Define a constant list of jokes. Each joke is an instance of the Joke class.
final JOKES_LIST = [
  Joke(
    id: 0, // The ID of the first joke
    category: 'cat1', // The category of the first joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ', // The content of the first joke
  ),
  Joke(
    id: 1, // The ID of the second joke
    category: 'cat1', // The category of the second joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ', // The content of the second joke
  ),
  Joke(
    id: 2, // The ID of the third joke
    category: 'cat1', // The category of the third joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 1 2', // The content of the third joke
  ),
  Joke(
    id: 3, // The ID of the fourth joke
    category: 'cat1', // The category of the fourth joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 3 ', // The content of the fourth joke
  ),
  Joke(
    id: 4, // The ID of the fifth joke
    category: 'cat2', // The category of the fifth joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 2 1', // The content of the fifth joke
  ),
  Joke(
    id: 5, // The ID of the sixth joke
    category: 'cat3', // The category of the sixth joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 1', // The content of the sixth joke
  ),
  Joke(
    id: 6, // The ID of the seventh joke
    category: 'cat3', // The category of the seventh joke
    content:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 2', // The content of the seventh joke
  ),
];
