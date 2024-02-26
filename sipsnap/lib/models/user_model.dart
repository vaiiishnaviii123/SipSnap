class UserModal {
  final String? uuid;
  final String? email;
  final String? name;
  final String? photoUrl;

  UserModal({
    this.uuid,
    this.email,
    this.name,
    this.photoUrl,
  });

  Object? toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  static UserModal fromMap(map) {
    return UserModal(
      uuid: map['uid'],
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
    );
  }
}