import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';
import 'package:sipsnap/view/common_widgets/comment_drawer.dart';
import 'package:sipsnap/view_model/comment_provider.dart';

class RecipePostCard extends StatefulWidget {
  final RecipePost post;

  const RecipePostCard({Key? key, required this.post}) : super(key: key);

  @override
  _RecipePostCardState createState() => _RecipePostCardState();
}

class _RecipePostCardState extends State<RecipePostCard> {
  int likeCount = 0;
  bool isLiked = false;

  void _submitComment(String comment) {
    // Here you can handle the submitted comment, for example, send it to a server or store it locally.
    print('Submitted comment: $comment');
    // You might also want to update the UI accordingly.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('card'),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Photo of the post
          if(widget.post.imageRef.isNotEmpty)Container(
            height: 200.0, // Adjust the height as needed
            width: double.infinity,
            color: Colors.grey, // Placeholder color
            child: Image.network(
                widget.post.imageRef,
                errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Center(
                      child: Text('😢 No image found.', style: TextStyle(color: Colors.white, fontSize: 20),
                      )
                  );
                },
                fit: BoxFit.cover,
                width: double.infinity),
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
                Text(widget.post.userName!),
                const SizedBox(height: 8.0),
                // Description
                Text(widget.post.description),
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
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        // Show the comment drawer
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const CommentDrawer();
                          },
                        );
                      },
                    ),
                    Text('Comments: ${ context.read<CommentProvider>().comments.length}'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
