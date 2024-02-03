// recipe_posts_provider.dart
import 'package:flutter/material.dart';
import 'package:sipsnap/data_classes/recipe_posts_model.dart';

class RecipePostsProvider extends ChangeNotifier {
  final List<RecipePost> _recipePosts = [
    RecipePost(
        recipeTitle: 'Delicious Boba Pearls',
        chefName: 'David',
        description: "Try golden pearl boba its amazing",
        imagePath: 'assets/boba2.jpg'),
  ];

  List<RecipePost> get recipePosts => _recipePosts;

  void addSampleRecipePost(RecipePost post) {
    _recipePosts.add(post);
    notifyListeners();
  }
}
