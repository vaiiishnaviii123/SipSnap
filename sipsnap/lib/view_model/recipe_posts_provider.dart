import 'package:flutter/material.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_view.dart';

import '../models/recipe_post_model.dart';

class RecipePostsProvider extends ChangeNotifier {
  final List<RecipePost> _recipePosts = [
    RecipePost(
      imagePath: 'assets/Caphil.jpeg',
      postTitle: 'Capitol Hill Boba Event',
      username: 'Shawn_56',
      ingredients: 'This is a sample description for post 1.',
      method: 'This is a sample description for post 1.',
      likes: 0,
    ),
    RecipePost(
      imagePath: 'assets/spaceneedle.jpg',
      postTitle: 'Space Needle Events',
      username: 'Ricky_007',
      ingredients: 'This is a sample description for post 2.',
      method: 'This is a sample description for post 2.',
      likes: 0,
    ),
  ];

  List<RecipePost> get recipePosts => _recipePosts;

  void addRecipePost(RecipePost post) {
    _recipePosts.add(post);
    notifyListeners();
  }
}
