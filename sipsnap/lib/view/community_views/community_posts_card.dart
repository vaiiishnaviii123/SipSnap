import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';

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
      key: const Key("card"),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              widget.post.username!,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
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
                  widget.post.postTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Username
                // Likes button and comments section
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
