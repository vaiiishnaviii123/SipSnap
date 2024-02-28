import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sipsnap/models/comment_model.dart';
import 'package:sipsnap/view_model/comment_provider.dart';

class CommentDrawer extends StatefulWidget {
  const CommentDrawer({Key? key, required TextEditingController controller})
      : super(key: key);

  @override
  _CommentDrawerState createState() => _CommentDrawerState();
}

class _CommentDrawerState extends State<CommentDrawer> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    Provider.of<CommentProvider>(context, listen: false).retrieveComments();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Consumer<CommentProvider>(
                builder: (context, commentProvider, _) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: commentProvider.comments.length,
                    itemBuilder: (context, index) {
                      Color cardColor =
                          index % 2 == 0 ? Colors.blue[50]! : Colors.blue[100]!;
                      return Card(
                        color: cardColor,
                        child: ListTile(
                          title: Text(commentProvider.comments[index].comment),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Write your comment',
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: () {
                      final String comment = _controller.text.trim();
                      const String username = "sample_username";
                      if (comment.isNotEmpty) {
                        final CommentProvider commentProvider =
                            Provider.of<CommentProvider>(context,
                                listen: false);
                        commentProvider.addComment(comment, username);
                        _controller.clear();
                      }
                    },
                    child: const Icon(Icons.send),
                  ),
                ],
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
