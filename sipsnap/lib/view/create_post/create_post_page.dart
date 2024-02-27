import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view/create_post/file_picker.dart';
import '../../models/recipe_posts_model.dart';
import '../../router.dart';
import '../../view_model/community_database_service.dart';
import '../../view_model/recipe_database_service.dart';
import '../../view_model/recipe_posts_provider.dart';
import '../../view_model/user_provider.dart';
import 'dart:io';

class CreatePostPage extends StatefulWidget {
   const CreatePostPage({super.key});

  @override
  createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dropdownController = TextEditingController();
  bool _isRecipe = false;
  bool _isCommunityPost = false;
  String message = "Community event Title";
  List<String> list = <String>['Community Post', 'Recipe Post'];
  String dropdownValue = "";
  RecipeDatabase recipeDatabase = new RecipeDatabase();
  CommunityDatabase communityDatabase = new CommunityDatabase();
  // image url for the image uploaded
  String imageUrl = "";
  String url = "";

  @override
  void initState() {
    _isRecipe = false;
    _isCommunityPost = true;
    super.initState();
  }

  void _setImageUrl(String url){
    setState(() {
      imageUrl = url;
    });
  }

  void _setUrl(String path){
    setState(() {
      url = path;
    });
  }

  void _onSavePressed(){
    String? userName =  context.read<UserProvider>().currentUser?.name;
    if(_isRecipe){
      RecipePost recipePost = RecipePost(
        imageRef: imageUrl,
        recipeTitle: titleController.text,
        userName: userName,
        description: descriptionController.text,
      );
      recipeDatabase.addRecipe(recipePost);
    }else{
      CommunityPost communityPost = CommunityPost(
        imageRef: imageUrl,
        postTitle: titleController.text,
        username: userName,
        description: descriptionController.text,
      );
      communityDatabase.addCommunityPost(communityPost);
    }
    titleController.clear();
    descriptionController.clear();
    url = "";
    imageUrl= "";
    if(_isRecipe){
      goRouter.go('/recipe');
    }else{
      goRouter.go('/community');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
        child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
          runSpacing:20,
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownMenu<String>(
              key: const Key("Type"),
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
          if(_isRecipe)Center(child: const Text("Recipe Post.", style: TextStyle(color:  Color.fromRGBO(99,122,159, 1), fontSize: 35))),
          if(_isCommunityPost)Center(child: const Text("Event Post.", style: TextStyle(color:  Color.fromRGBO(99,122,159, 1), fontSize: 35))),
          //const Text("Title:", style: TextStyle(color: Colors.black54, fontSize: 25)),
          TextFormField(
            key: Key("Title"),
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
          // camera and gallery icon button
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child:  FilePicker(_setImageUrl, _setUrl),
          ),
          if(url.isNotEmpty)Container(
            height: 400.0,
            color: Colors.grey,
            child: Image.file(File(url), fit: BoxFit.cover, width: double.infinity),
          ),
          if(_isRecipe)const Text("Ingredients and Method.", style: TextStyle(color: Colors.black54, fontSize: 20)),
          if(_isCommunityPost)const Text("Description.", style: TextStyle(color: Colors.black54, fontSize: 20)),
          TextFormField(
            key: Key("Description"),
            controller: descriptionController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
              labelText: "Enter here."
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
              key: Key("SavePost"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
                backgroundColor: Color.fromRGBO(99,122,159, 1),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // you'd often call a server or save the information in a database.
                  _onSavePressed();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      key: Key("SnackBar"),
                      content: Text("Posted successfully!", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                      backgroundColor: Color.fromRGBO(232,200,114, 1),
                    ),
                  );
                }
                FocusScope.of(context).unfocus();
              },
              child: const Text('Save'),
            ),
          ),
        ],
        ),
    ),
      ),
    );
  }
}