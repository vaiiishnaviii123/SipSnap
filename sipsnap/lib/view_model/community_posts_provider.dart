import 'package:flutter/material.dart';
import 'package:sipsnap/models/community_posts_model.dart';

class CommunityPostsProvider extends ChangeNotifier {
  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      postTitle: 'Capitol Hill Boba Event',
      username: 'Shawn_56',
      description: 'This is a sample description for post 1.',
      imageRef: 'assets/boba1.jpg',
    ),
    CommunityPost(
      postTitle: 'Space Needle Events',
      username: 'Ricky_007',
      description: 'This is a sample description for post 2.',
      imageRef: 'assets/spaceneedle.jpg',
    ),
  ];

  List<CommunityPost> get communityPosts => _communityPosts;

  void addCommunityPost(CommunityPost post) {
    _communityPosts.add(post);
    notifyListeners();
  }
}
