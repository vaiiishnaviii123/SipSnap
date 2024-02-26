import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/community_posts_model.dart';
import 'package:sipsnap/view_model/community_posts_provider.dart';
import '../../models/recipe_posts_model.dart';
import '../../view_model/community_database_service.dart';
import '../../view_model/recipe_database_service.dart';
import '../../view_model/recipe_posts_provider.dart';

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


  Future<void> _getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {

      // reference to the firebase storage
      Reference ref = FirebaseStorage.instance.ref().child('images');

      // reference to the image file
      //make unique image name
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference file = ref.child(uniqueName);

      // uploading the image
      await file.putFile(File(image.path));

      // getting the image url
      imageUrl = await file.getDownloadURL();

      print(imageUrl);
    }
  }

  @override
  void initState() {
    _isRecipe = false;
    _isCommunityPost = true;
    super.initState();
  }

  void _onSavePressed(){
    if(_isRecipe){
      RecipePost recipePost = RecipePost(
        imageRef: 'assets/spaceneedle.jpg',
        recipeTitle: titleController.text,
        userName: 'admin',
        description: descriptionController.text,
      );
      context.read<RecipePostsProvider>().addRecipePost(recipePost);
      recipeDatabase.addRecipe(recipePost);
    }else{
      CommunityPost communityPost = CommunityPost(
        imageRef: 'assets/spaceneedle.jpg',
        postTitle: titleController.text,
        username: 'admin',
        description: descriptionController.text,
      );
      context.read<CommunityPostsProvider>().addCommunityPost(communityPost);
      communityDatabase.addCommunityPost(communityPost);
    }
    titleController.clear();
    descriptionController.clear();
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
          runSpacing:7,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () async {
                  await _getImage(ImageSource.camera);
                  // this is the image url store it in the community post or recipe post
                  print(imageUrl);

                },
                icon: const Icon(Icons.camera_alt, color: Colors.black, size: 35),
              ),
              IconButton(
                onPressed: () async{
                  await _getImage(ImageSource.gallery);
                  // this is the image url store it in the community post or recipe post
                  print(imageUrl);
                },
                icon: const Icon(Icons.photo, color: Colors.black, size: 35),
              ),
            ],
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