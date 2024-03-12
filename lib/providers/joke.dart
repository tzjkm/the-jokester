class Joke {
  final int id;
  final String category;
  String
      content; // The individual jokes can have list of text that can be displayed on top of each other

  bool isFavorite = false; // This needs to be stored in database

  Joke({
    required this.id,
    required this.category,
    required this.content,
    isFavorite = false,
  });
}
