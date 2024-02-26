import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/recipe_posts_model.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_page.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';

void main() {
  group('recipe_posts_test', () {
    testWidgets('Recipe Posts Widget renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<RecipePostsProvider>(
            create: (_) => MockRecipePostsProvider(),
            child: const RecipePosts(),
          ),
        ),
      );

      expect(find.text('Boba Recipes'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Recipe Post Card Widget renders correctly',
        (WidgetTester tester) async {
      final recipePost = RecipePost(
        recipeTitle: 'Test Recipe',
        userName: 'TestChef',
        description: 'Test Description',
        imageRef: 'assets/boba2.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: RecipePostCard(post: recipePost),
        ),
      );

      expect(find.text('Test Recipe'), findsOneWidget);
      expect(find.text('TestChef'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });
  });
}

// Mock RecipePostsProvider for testing
class MockRecipePostsProvider extends RecipePostsProvider {
  @override
  List<RecipePost> get recipePosts => [
        RecipePost(
          recipeTitle: 'Mock Recipe 1',
          userName: 'MockChef1',
          description: 'Mock Description 1',
          imageRef: 'assets/boba2.jpg',
        ),
        RecipePost(
          recipeTitle: 'Mock Recipe 2',
          userName: 'MockChef2',
          description: 'Mock Description 2',
          imageRef: 'assets/boba2.jpg',
        ),
      ];
}
