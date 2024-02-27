import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sipsnap/models/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  final List<Comment> _comments = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Comment> get comments => _comments;

  Future<void> addComment(String commentText, String username) async {
    try {
      // Add comment locally
      _comments.add(Comment(commentText));
      notifyListeners();

      // Send comment data to Firestore
      await _firestore.collection('comments').add({
        'commentText': commentText,
        'username': username,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Handle error
      print('Error adding comment: $e');
    }
  }
}
