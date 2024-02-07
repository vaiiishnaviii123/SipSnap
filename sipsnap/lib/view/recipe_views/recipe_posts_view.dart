import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';

class RecipePosts extends StatelessWidget {
  const RecipePosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accessing the RecipePostsProvider
    var recipePostsProvider = Provider.of<RecipePostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boba Recipes'),
      ),
      body: ListView.builder(
        itemCount: recipePostsProvider.recipePosts.length,
        itemBuilder: (context, index) {
          var post = recipePostsProvider.recipePosts[index];
          return RecipePostCard(post: post);
        },
      ),
    );
  }
}

class RecipePostCard extends StatefulWidget {
  final RecipePost post;

  const RecipePostCard({Key? key, required this.post}) : super(key: key);

  @override
  _RecipePostCardState createState() => _RecipePostCardState();
}

class _RecipePostCardState extends State<RecipePostCard> {
  int likeCount = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('card'),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Photo of the post
          Container(
            height: 200.0,
            width: double.infinity,
            color: Colors.grey,
            child: Image.asset(widget.post.imagePath, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of the post
                Text(
                  widget.post.recipeTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Chef's name
                Text(widget.post.userName),
                // Likes button and comments section
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                          likeCount += isLiked ? 1 : -1;
                        });
                      },
                    ),
                    const SizedBox(width: 4.0),
                    Text('Likes: $likeCount'),
                    const SizedBox(width: 16.0),
                    //const Icon(Icons.comment),
                    //const SizedBox(width: 4.0),
                    //const Text('Comments: 0'),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Description
                Text(widget.post.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
