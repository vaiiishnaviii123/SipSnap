import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/models/recipe_post_model.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';

import '../../view_model/recipe_posts_provider.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  _CreatePostState createState() {
    return _CreatePostState();
  }
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController methodController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool _isRecipe = false;
  bool _isCommunityPost = false;

  @override
  void initState() {
    _isRecipe = false;
    _isCommunityPost = true;
    super.initState();
  }

  void _onSavePressed(){
    if(_isRecipe){
      RecipePost recipePost = RecipePost(
        imagePath: 'assets/spaceneedle.jpg',
        postTitle: titleController.text,
        username: 'admin',
        ingredients: ingredientsController.text,
        method: methodController.text,
        likes: 0,
      );
      context.read<RecipePostsProvider>().addRecipePost(recipePost);
    }else{
      CommunityPost communityPost = new CommunityPost(
        imagePath: 'assets/spaceneedle.jpg',
        postTitle: titleController.text,
        username: 'admin',
        description: descriptionController.text,
      );
      context.read<CommunityPostsProvider>().addCommunityPost(communityPost);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(_isRecipe)Center(child: const Text("Recipe Post.", style: TextStyle(color: Colors.black54, fontSize: 35))),
          if(_isCommunityPost)Center(child: const Text("Event Post.", style: TextStyle(color: Colors.black54, fontSize: 35))),
          //const Text("Title:", style: TextStyle(color: Colors.black54, fontSize: 25)),
          TextFormField(
            key: Key("Title."),
            controller: titleController,
            decoration: InputDecoration(
             labelText: "Post Title",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title.';
              }
              return null;
            },
          ),
          const Text("Add Picture.", style: TextStyle(color: Colors.black54, fontSize: 25)),
          Center(
              child: Container(
              height: 200.0, // Adjust the height as needed
              width: 380.0,
              color: Colors.grey, // Placeholder color
              child: Image.asset('assets/spaceneedle.jpg', fit: BoxFit.cover)
            )
          ),
          if(_isRecipe)const Text("Ingredients.", style: TextStyle(color: Colors.black54, fontSize: 25)),
          if(_isRecipe)TextFormField(
            key: Key("Ingredients."),
            controller: ingredientsController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                gapPadding: 10.0,
              ),
              labelText: 'Recomended: Specify ingredient quantity.',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the ingredients.';
              }
              return null;
            },
          ),
          if(_isRecipe)const Text("Method.", style: TextStyle(color: Colors.black54, fontSize: 25)),
          if(_isRecipe)TextFormField(
            key: Key("Method."),
            controller: methodController,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the method.';
              }
              return null;
            },
          ),
          if(_isCommunityPost)const Text("Description.", style: TextStyle(color: Colors.black54, fontSize: 25)),
          if(_isCommunityPost)TextFormField(
            key: Key("Description."),
            controller: descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the description.';
              }
              return null;
            },
          ),
          Center(
            child: ElevatedButton(
              key: Key("SaveButton"),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
                  _onSavePressed();
                }
                FocusScope.of(context).unfocus();
              },
              child: const Text('Save'),
            ),
          ),
        ],
        ),
      ),
    );
  }
}