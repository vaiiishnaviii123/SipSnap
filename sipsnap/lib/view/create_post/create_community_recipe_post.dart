import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view/community_views/community_posts_view.dart';
import 'package:sipsnap/view/home_screen.dart';
import 'package:sipsnap/view/recipe_views/recipe_posts_view.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';

import '../../models/recipe_posts_model.dart';
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
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  bool _isRecipe = false;
  bool _isCommunityPost = false;
  String message = "Community event Title";
  List<String> list = <String>['Community Post', 'Recipe Post'];
  String dropdownValue = "";

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
        recipeTitle: titleController.text,
        userName: 'admin',
        description: descriptionController.text,
      );
      context.read<RecipePostsProvider>().addRecipePost(recipePost);
      message = "Recipe posted successfully!";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Recipe posted successfully!", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromRGBO(232,200,114, 1),
        ),
      );
    }else{
      CommunityPost communityPost = new CommunityPost(
        imagePath: 'assets/spaceneedle.jpg',
        postTitle: titleController.text,
        username: 'admin',
        description: descriptionController.text,
      );
      context.read<CommunityPostsProvider>().addCommunityPost(communityPost);
      message = "Event posted successfully!";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Event posted successfully!", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
          backgroundColor: Color.fromRGBO(232,200,114, 1),
        ),
      );
    }
    titleController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
          runSpacing:7,
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownMenu<String>(
              initialSelection: list.first,
              controller: dropdownController,
              requestFocusOnTap: true,
              label: const Text('Select Post type'),
              onSelected: (String? value) {
                setState(() {
                      dropdownValue = value!;
                      if(dropdownValue == "Community Post"){
                        message = "Community event Title";
                        _isCommunityPost = true;
                        _isRecipe = false;
                      }else{
                        message = "Recipe Title";
                        _isRecipe = true;
                        _isCommunityPost = false;
                      }
                    });
              },
              dropdownMenuEntries: list
                  .map<DropdownMenuEntry<String>>(
                      (String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  }).toList(),
            ),
      ]),
      //         // const Text("Select Post type.", style: TextStyle(color: Colors.black54, fontSize: 15)),
      //     Center(child: DropdownButton<String>(
      //     value: list.first,
      //     icon: const Icon(Icons.arrow_downward),
      //     elevation: 16,
      //     style: const TextStyle(color: Colors.deepPurple),
      //     underline: Container(
      //       height: 2,
      //       color: Colors.deepPurpleAccent,
      //     ),
      //     onChanged: (String? value) {
      //       // This is called when the user selects an item.
      //       setState(() {
      //         dropdownValue = value!;
      //         if(dropdownValue == "Community Post"){
      //           _isCommunityPost = true;
      //           _isRecipe = false;
      //         }else{
      //           _isRecipe = true;
      //           _isCommunityPost = false;
      //         }
      //       });
      //     },
      //     items: list.map<DropdownMenuItem<String>>((String value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //   ),
      //     ),
          if(_isRecipe)Center(child: const Text("Recipe Post.", style: TextStyle(color:  Color.fromRGBO(99,122,159, 1), fontSize: 35))),
          if(_isCommunityPost)Center(child: const Text("Event Post.", style: TextStyle(color:  Color.fromRGBO(99,122,159, 1), fontSize: 35))),
          //const Text("Title:", style: TextStyle(color: Colors.black54, fontSize: 25)),
          TextFormField(
            key: Key("Title."),
            controller: titleController,
            decoration: InputDecoration(
             labelText: message,
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title.';
              }
              return null;
            },
          ),
          const Text("Add Picture.", style: TextStyle(color: Colors.black54, fontSize: 20)),
          Center(
              child: Container(
              height: 200.0, // Adjust the height as needed
              width: 380.0,
              color: Colors.grey, // Placeholder color
              child: Image.asset('assets/spaceneedle.jpg', fit: BoxFit.cover)
            )
          ),
          if(_isRecipe)const Text("Ingredients and Method.", style: TextStyle(color: Colors.black54, fontSize: 20)),
          if(_isCommunityPost)const Text("Description.", style: TextStyle(color: Colors.black54, fontSize: 20)),
          TextFormField(
            key: Key("Description."),
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: "Enter description here."
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
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Color.fromRGBO(99,122,159, 1),
                foregroundColor: Colors.white,
              ),
              key: Key("SaveButton"),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
                  _onSavePressed();
                  if(_isCommunityPost) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CommunityPosts()),
                    );
                  }
                  if(_isRecipe){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RecipePosts()),
                    );
                  }
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