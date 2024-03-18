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
]; // Define a constant list of jokes. Each joke is an instance of the Joke class.
final JOKES_LIST = [
  Joke(
    id: 0,
    category: 'cat1',
    content: 'How do you organize a space party?\nYou planet.',
  ),
  Joke(
    id: 1,
    category: 'cat1',
    content: 'Why couldn\'t the bicycle stand up by itself?\nIt was two tired.',
  ),
  Joke(
    id: 2,
    category: 'cat1',
    content:
        'Did you hear the rumor about butter?\nWell, I\'m not going to spread it.',
  ),
  Joke(
    id: 3,
    category: 'cat1',
    content:
        'Why did the student eat his homework?\nBecause his teacher told him it was a piece of cake.',
  ),
  Joke(
    id: 4,
    category: 'cat1',
    content:
        'What did one hat say to the other?\nYou wait here, I\'ll go on ahead.',
  ),
  Joke(
    id: 5,
    category: 'cat1',
    content:
        'What do you call a dinosaur that crashes his car?\nTyrannosaurus Wrecks.',
  ),
  Joke(
    id: 6,
    category: 'cat2',
    content:
        'I couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
  ),
  Joke(
    id: 7,
    category: 'cat2',
    content:
        'I couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
  ),
  Joke(
    id: 8,
    category: 'cat2',
    content:
        'I couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
  ),
];

final Map<String, List<Joke>> CATEGORYWISE_JOKES = {
  'cat1': [
    Joke(
      id: 0,
      category: 'cat1',
      content: 'How do you organize a space party?\nYou planet.',
    ),
    Joke(
      id: 1,
      category: 'cat1',
      content:
          'Why couldn\'t the bicycle stand up by itself?\nIt was two tired.',
    ),
    Joke(
      id: 2,
      category: 'cat1',
      content:
          'Did you hear the rumor about butter?\nWell, I\'m not going to spread it.',
    ),
    Joke(
      id: 3,
      category: 'cat1',
      content:
          'Why did the student eat his homework?\nBecause his teacher told him it was a piece of cake.',
    ),
    Joke(
      id: 4,
      category: 'cat1',
      content:
          'What did one hat say to the other?\nYou wait here, I\'ll go on ahead.',
    ),
    Joke(
      id: 5,
      category: 'cat1',
      content:
          'What do you call a dinosaur that crashes his car?\nTyrannosaurus Wrecks.',
    ),
  ],
  'cat2': [
    Joke(
      id: 6,
      category: 'cat2',
      content:
          'I category 2 6 couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
    ),
    Joke(
      id: 7,
      category: 'cat2',
      content:
          'I category 2 7 couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
    ),
    Joke(
      id: 8,
      category: 'cat2',
      content:
          'I  category 2 8 couldn\'t figure out why the baseball kept getting larger.\nThen it hit me.',
    ),
  ]
};



// // Define a constant list of jokes. Each joke is an instance of the Joke class.
// final JOKES_LIST = [
//   Joke(
//     id: 0, // The ID of the first joke
//     category: 'cat1', // The category of the first joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ', // The content of the first joke
//   ),
//   Joke(
//     id: 1, // The ID of the second joke
//     category: 'cat1', // The category of the second joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 1 ', // The content of the second joke
//   ),
//   Joke(
//     id: 2, // The ID of the third joke
//     category: 'cat1', // The category of the third joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 1 2', // The content of the third joke
//   ),
//   Joke(
//     id: 3, // The ID of the fourth joke
//     category: 'cat1', // The category of the fourth joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit,cat 1 3 ', // The content of the fourth joke
//   ),
//   Joke(
//     id: 4, // The ID of the fifth joke
//     category: 'cat2', // The category of the fifth joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 2 1', // The content of the fifth joke
//   ),
//   Joke(
//     id: 5, // The ID of the sixth joke
//     category: 'cat3', // The category of the sixth joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 1', // The content of the sixth joke
//   ),
//   Joke(
//     id: 6, // The ID of the seventh joke
//     category: 'cat3', // The category of the seventh joke
//     content:
//         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, cat 3 2', // The content of the seventh joke
//   ),
// ];
