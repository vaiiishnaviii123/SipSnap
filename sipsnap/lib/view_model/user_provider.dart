import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sipsnap/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModal? _currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late StreamSubscription<User?> _authStateChangesSubscription;
  late StreamController<UserModal?> _userStreamController;

  UserModal? get currentUser => _currentUser;

  // Initialize the provider
  UserProvider() {
    _userStreamController = StreamController<UserModal?>();
    _authStateChangesSubscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is signed in
        _currentUser = UserModal(
          uuid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          photoUrl: user.photoURL ?? '',
        );
      } else {
        // User is signed out
        _currentUser = null;
      }
      // Add the current user to the stream
      _userStreamController.add(_currentUser);
    });
  }

  // Stream to listen for user authentication state changes
  Stream<UserModal?> get userStream => _userStreamController.stream;

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        final User? user = userCredential.user;
        if (user != null) {
          _currentUser = UserModal(
            uuid: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            photoUrl: user.photoURL ?? '',
          );
          _userStreamController.add(_currentUser);
          addUserToFirestore(_currentUser!);
        } else {
          print("Failed to sign in with Google.");
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      _currentUser = null;
      _userStreamController.add(null);
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // Add user to Firestore
  void addUserToFirestore(UserModal user) async {
    try {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');
      await usersCollection.doc(user.uuid).set(user.toMap());
      print('User added to Firestore successfully');
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }
}
