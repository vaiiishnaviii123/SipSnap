import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/view_model/community_database_service.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import 'package:sipsnap/view/community_views/community_posts_card.dart';

class CommunityPostsPage extends StatelessWidget {
  const CommunityPostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityPostsProvider>(context);

    // Fetch community posts when the page is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CommunityDatabase>().fetchCommunityPosts(communityProvider);
    });

    return Scaffold(
      body: Consumer<CommunityPostsProvider>(
        builder: (context, communityPostsProvider, _) {
          return ListView.builder(
            key: ValueKey('list'),
            itemCount: communityPostsProvider.communityPosts.length,
            itemBuilder: (context, index) {
              var post = communityPostsProvider.communityPosts[index];
              return CommunityPostCard(post: post);
            },
          );
        },
      ),
    );
  }
}
