import 'package:flutter/material.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';

class RecipePostsProvider extends ChangeNotifier {
  List<RecipePost> _recipePosts = [];

  List<RecipePost> get recipePosts => _recipePosts;

  void setRecipePosts(List<RecipePost> posts) {
    _recipePosts = posts;
    notifyListeners();
  }

  List<RecipePost> getRecipePosts(){
    return _recipePosts.toList();
  }
}