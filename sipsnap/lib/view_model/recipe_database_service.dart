import 'package:cloud_firestore/cloud_firestore.dart';
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
}