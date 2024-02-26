import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view/community_views/community_posts_card.dart';

class CommunityPostsPage extends StatelessWidget {
  const CommunityPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommunityPostsProvider(),
      child: Scaffold(
        body: Consumer<CommunityPostsProvider>(
          builder: (context, communityPostsProvider, _) {
            return ListView.builder(
              itemCount: communityPostsProvider.communityPosts.length,
              itemBuilder: (context, index) {
                var post = communityPostsProvider.communityPosts[index];
                return CommunityPostCard(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
