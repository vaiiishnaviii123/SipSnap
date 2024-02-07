import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';

class CommunityPosts extends StatelessWidget {
  const CommunityPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accessing the CommunityPostsProvider
    var communityPostsProvider = Provider.of<CommunityPostsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boba Community Posts'),
      ),
      body: ListView.builder(
        itemCount: communityPostsProvider.communityPosts.length,
        itemBuilder: (context, index) {
          var post = communityPostsProvider.communityPosts[index];
          return CommunityPostCard(post: post);
        },
      ),
    );
  }
}

class CommunityPostCard extends StatefulWidget {
  final CommunityPost post;

  const CommunityPostCard({Key? key, required this.post}) : super(key: key);

  @override
  _CommunityPostCardState createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends State<CommunityPostCard> {
  int likeCount = 0;
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key("card"),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Photo of the post
          Container(
              height: 200.0, // Adjust the height as needed
              width: double.infinity,
              color: Colors.grey, // Placeholder color
              child: Image.asset(widget.post.imagePath, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of the post
                Text(
                  widget.post.postTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Username
                Text(widget.post.username),
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
                //  Description
                Text(widget.post.description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
