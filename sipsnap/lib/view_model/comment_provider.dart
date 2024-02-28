import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sipsnap/models/comment_model.dart';

class CommentProvider extends ChangeNotifier {
  final List<Comment> _comments = [];
  late FirebaseFirestore _firestore;

  CommentProvider(FirebaseFirestore db){
    _firestore = db;
  }

  List<Comment> get comments => _comments;

  Future<void> addComment(String comment, String username) async {
    try {
      // Add comment locally
      _comments.add(Comment(comment));
      notifyListeners();

      // Send comment data to Firestore
      await _firestore.collection('comments').add({
        'comment': comment,
        'username': username,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // Handle error
      print('Error adding comment: $e');
    }
  }

  Future<void> retrieveComments() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('comments').get();

      _comments.addAll(querySnapshot.docs.map((doc) {
        return Comment(
          doc['comment'],
        );
      }));

      notifyListeners();
    } catch (e) {
      print('Error retrieving comments: $e');
    }
  }
}
