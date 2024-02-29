import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/recipe_database_service.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_card.dart';

class RecipePostsPage extends StatelessWidget {
  const RecipePostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipePostsProvider>(context);

    // Fetch community posts when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await  context.read<RecipeDatabase>().fetchRecipePosts(recipeProvider);
    });

    return Scaffold(
      backgroundColor:  Color.fromRGBO(250, 238, 230,1),
      body: Consumer<RecipePostsProvider>(
        builder: (context, recipePostsProvider, _) {
          return ListView.builder(
            key: ValueKey('list'),
            itemCount: recipePostsProvider.recipePosts.length,
            itemBuilder: (context, index) {
              var post = recipePostsProvider.recipePosts[index];
              return RecipePostCard(post: post);
            },
          );
        },
      ),
    );
  }
}