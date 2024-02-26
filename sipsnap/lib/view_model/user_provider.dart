import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sipsnap/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider extends ChangeNotifier {
  List<UserModal>? _user;
  UserModal? _currentUser;

  List<UserModal>? get user => _user;

  void setUser(List<UserModal> user) {
    _user = user;
    notifyListeners();
  }

  UserModal? get currentUser => _currentUser;

  void setCurrentUser(UserModal user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    // sign in with google
    final GoogleSignIn googleSignIn = GoogleSignIn();

    //sign in with google
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    try{
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        // create new credential
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        // sign in with credential
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        // retrive the user info
        final User? user = userCredential.user;

        if (user != null) {
         // create new user object
          UserModal newUser = UserModal(
            uuid: user.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
          );

          // set current user
          setCurrentUser(newUser);

          // add user to firestore
          addUserToFirestore(newUser);

        } else {
          print("Failed to sign in with google.");
        }
      }
    }catch (e){
      print("error caught: $e");
    }
  }

  void addUserToFirestore(UserModal user) async {
    try {
      // Reference to the Firestore collection named 'Users'
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

      // Add the user data to Firestore
      await usersCollection.doc(user.uuid).set(user.toMap());

      print('User added to Firestore successfully');
    } catch (e) {
      print('Error adding user to Firestore: $e');
      // Handle the error appropriately (e.g., show error message to the user)
    }
  }

  Future<void> signOut() async {
    // sign out from google
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    setCurrentUser(UserModal());
    notifyListeners();
  }

}
