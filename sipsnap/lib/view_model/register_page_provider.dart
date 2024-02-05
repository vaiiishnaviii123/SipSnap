import 'package:flutter/material.dart';
import 'package:sipsnap/models/register_page_event.dart';

class RegisterPageProvider extends ChangeNotifier {

  final List<RegisterPageEvent> _registerPageEvent = [];

  // Getter to get all the registerPageEvent
  List<RegisterPageEvent> get registerPageEvent => _registerPageEvent;

  // Function to add registerPageEvent
  void addRegisterPageEvent(RegisterPageEvent registerPageEvent) {
    _registerPageEvent.add(registerPageEvent);
    notifyListeners();
  }

  // Function to check for a duplicate email currently just a linear search
  bool checkForDuplicateEmail(String email) {
    for (var i = 0; i < _registerPageEvent.length; i++) {
      if (_registerPageEvent[i].email == email) {
        return true;
      }
    }
    return false;
  }

  // Function to search a user by email currently just a linear search 
  bool searchUserCheckPassword(String email, String password) {
    for (var i = 0; i < _registerPageEvent.length; i++) {
      if (_registerPageEvent[i].email == email && _registerPageEvent[i].password == password) {
        return true;
      }
    }
    return false;
  }

}