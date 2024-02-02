// community_posts.dart
import 'package:flutter/material.dart';

class CommunityPosts extends StatelessWidget {
  const CommunityPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boba Community Posts'),
      ),
      body: const Center(
        child: Text('Community Posts'),
      ),
    );
  }
}
