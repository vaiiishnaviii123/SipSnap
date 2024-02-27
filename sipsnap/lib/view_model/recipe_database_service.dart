import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sipsnap/view_model/recipe_posts_provider.dart';
import '../models/recipe_posts_model.dart';

class RecipeDatabase{

  final CollectionReference recipeCollection = FirebaseFirestore.instance.collection('recipies');

  Future addRecipe(RecipePost recipePostModal) async {
    return await recipeCollection.add({
      'recipeTitle': recipePostModal.recipeTitle,
      'userName': recipePostModal.userName,
      'description': recipePostModal.description,
      'imageRef': recipePostModal.imageRef
    });
  }

  Future<void> fetchRecipePosts(RecipePostsProvider provider) async {
    try {
      QuerySnapshot querySnapshot = await recipeCollection.get();
      List<RecipePost> posts = [];
      for (var doc in querySnapshot.docs) {
        posts.add(
            RecipePost(
          recipeTitle: doc['recipeTitle'],
          userName: doc['userName'],
          description: doc['description'],
          imageRef: doc['imageRef'],
        )
        );
      }
      provider.setRecipePosts(posts);
    } catch (error) {
      print("Error fetching community posts: $error");
      throw error;
    }
  }
}