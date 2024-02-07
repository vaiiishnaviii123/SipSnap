import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view/community_views/community_posts_view.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';

void main() {
  group('community_posts_test', () {
    testWidgets('Community Posts Widget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<CommunityPostsProvider>(
            create: (_) => MockCommunityPostsProvider1(),
            child: const CommunityPosts(),
          ),
        ),
      );

      expect(find.text('Boba Community Posts'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Community Post Card Widget renders correctly',
        (WidgetTester tester) async {
      final communityPost = CommunityPost(
        postTitle: 'Test Post',
        username: 'TestUser',
        description: 'Test Description',
        imagePath: 'assets/spaceneedle.jpg', // Commented out for now
      );

      await tester.pumpWidget(
        MaterialApp(
          home: CommunityPostCard(post: communityPost),
        ),
      );

      expect(find.text('Test Post'), findsOneWidget);
      expect(find.text('TestUser'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });
  });
}

// Mock CommunityPostsProvider for testing
class MockCommunityPostsProvider1 extends CommunityPostsProvider {
  @override
  List<CommunityPost> get communityPostsList => [
        CommunityPost(
          postTitle: 'Mock Post 1',
          username: 'MockUser1',
          description: 'Mock Description 1',
          imagePath: 'assets/spaceneedle.jpg', // Commented out for now
        ),
        CommunityPost(
          postTitle: 'Mock Post 2',
          username: 'MockUser2',
          description: 'Mock Description 2',
          imagePath: 'assets/spaceneedle.jpg', // Commented out for now
        ),
      ];
}
