import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/comment_model.dart';
import 'package:sipsnap/view_model/comment_provider.dart';

class CommentDrawer extends StatefulWidget {
  const CommentDrawer({Key? key}) : super(key: key);

  @override
  _CommentDrawerState createState() => _CommentDrawerState();
}

class _CommentDrawerState extends State<CommentDrawer> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Write your comment',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final String commentText = _controller.text.trim();
                if (commentText.isNotEmpty) {
                  final CommentProvider commentProvider =
                      Provider.of<CommentProvider>(context, listen: false);
                  commentProvider.addComment(Comment(commentText));
                  _controller.clear();
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Consumer<CommentProvider>(
                builder: (context, commentProvider, _) {
                  return ListView.builder(
                    itemCount: commentProvider.comments.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(commentProvider.comments[index].text),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
