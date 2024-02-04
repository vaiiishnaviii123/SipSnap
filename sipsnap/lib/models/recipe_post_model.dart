class RecipePost {
  final String imagePath;
  final String postTitle;
  final String username;
  final String ingredients;
  final String method;
  final int likes;

  RecipePost({
    required this.imagePath,
    required this.postTitle,
    required this.username,
    required this.ingredients,
    required this.method,
    required this.likes
  });
}