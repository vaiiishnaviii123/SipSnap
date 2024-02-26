import 'package:flutter/material.dart';
import 'package:sipsnap/models/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  final List<Comment> _comments = [];

  List<Comment> get comments => _comments;

  void addComment(Comment comment) {
    _comments.add(comment);
    notifyListeners();
  }
}
