import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sipsnap/models/user_model.dart';

void main() {
  test('toMap() method converts UserModal object to map', () {
    // Create a UserModal object
    var user = UserModal(
      uuid: '12345',
      name: 'John Doe',
      email: 'john@example.com',
      photoUrl: 'https://example.com/avatar.jpg',
    );

    // Define the expected map
    var expectedMap = {
      'uuid': '12345',
      'name': 'John Doe',
      'email': 'john@example.com',
      'photoUrl': 'https://example.com/avatar.jpg',
    };

    // Call the toMap() method
    var userMap = user.toMap() as Map<String, dynamic>?;

    // Verify that the returned map is equal to the expected map
    expect(userMap, equals(expectedMap));
  });

  test('fromMap() method creates UserModal object from map', () {
    // Define a user data map
    var userData = {
      'uuid': '12345',
      'name': 'John Doe',
      'email': 'john@example.com',
      'photoUrl': 'https://example.com/avatar.jpg',
    };

    // Call the fromMap() method
    var mapUser = UserModal.fromMap(userData);

    // Verify the returned object is instance of UserModal
    expect(mapUser, isA<UserModal>());
  });
}
