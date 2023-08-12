class User {
  int userID;
  String userEmail;
  String firstName;
  String lastName;
  String userAvatar;

  User(
      {required this.userID,
      required this.userEmail,
      required this.firstName,
      required this.lastName,
      required this.userAvatar});

  static User fromJson(Map<String, dynamic> json) {
    return User(
        userID: json['id'],
        userEmail: json['email'],
        firstName: json['first_name'],
        lastName: json["last_name"],
        userAvatar: json["avatar"]);
  }

  toJson() {
    return {
      'id': userID,
      'email': userEmail,
      'first_name': firstName,
      "last_name": lastName,
      'avatar': userAvatar
    };
  }
}
