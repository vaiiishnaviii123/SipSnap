import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_card.dart';

class RecipePostsPage extends StatelessWidget {
  const RecipePostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipePostsProvider(),
      child: Scaffold(
        body: Consumer<RecipePostsProvider>(
          builder: (context, recipePostsProvider, _) {
            return ListView.builder(
              itemCount: recipePostsProvider.recipePosts.length,
              itemBuilder: (context, index) {
                var post = recipePostsProvider.recipePosts[index];
                return RecipePostCard(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}