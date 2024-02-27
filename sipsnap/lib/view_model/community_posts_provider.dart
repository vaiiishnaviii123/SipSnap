import 'package:flutter/material.dart';
import 'package:sipsnap/models/community_posts_model.dart';

class CommunityPostsProvider extends ChangeNotifier {
  List<CommunityPost> _communityPosts = [];

  List<CommunityPost> get communityPosts => _communityPosts;

  void setCommunityPosts(List<CommunityPost> posts) {
    _communityPosts = posts;
    notifyListeners();
  }
}
