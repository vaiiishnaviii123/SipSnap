import 'package:flutter/material.dart';

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  _CreatePostDialogState createState() {
    return _CreatePostDialogState();
  }
}

class _CreatePostDialogState extends State<CreatePostDialog> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
            title: const Text('Select Post Type'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createPost');
                    // Navigate to post form with Community type
                  },
                  child: const Text('Community Post'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/createRecipe');
                    // Navigate to post form with Recipe type
                  },
                  child: const Text('Recipe'),
                ),
              ],
            ),
          );
  }
}