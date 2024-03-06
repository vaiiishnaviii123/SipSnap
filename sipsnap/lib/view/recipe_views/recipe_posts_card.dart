import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';

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
      key: const Key('card'),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_circle,
                  color: Colors.blueGrey, size: 40),
              const SizedBox(height: 8.0),
              const SizedBox(width: 8.0),
              Text(widget.post.userName!),
            ],
          ),
          // 1. Photo of the post
          if (widget.post.imageRef.isNotEmpty)
            Container(
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              color: Colors.grey, // Placeholder color
              child: Image.network(widget.post.imageRef, errorBuilder:
                  (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                return const Center(
                    child: Text(
                  '😢 No image found.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ));
              }, fit: BoxFit.cover, width: double.infinity),
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
                const SizedBox(height: 8.0),
                // Description
                Text(widget.post.description),
                // Likes button and comments section
              ],
            ),
          ),
        ],
      ),
    );
  }
}
