// It is class named Joke
class Joke {
  // Define a final variable id of type int
  // This variable is used to store the unique identifier of the joke
  final int id;

  // Define a final variable category of type String
  // This variable is used to store the category of the joke
  final String category;

  // Define a variable content of type String
  // This variable is used to store the content of the joke
  // The content can be a list of text that can be displayed on top of each other
  // This is why it's not marked as final, as the content can change
  String content;

  // Define a variable isFavorite of type bool and initialize it to false
  // This variable is used to store whether the joke is a favorite or not
  // This information needs to be stored in a database, hence it's not marked as final
  bool isFavorite;

  // Define a constructor for Joke that takes id, category, and content as required named parameters, and isFavorite as an optional named parameter
  // This constructor is used to create a new instance of Joke
  // The isFavorite parameter is optional and defaults to false if not provided
  Joke({
    required this.id,
    required this.category,
    required this.content,
    this.isFavorite = false,
  });
}
