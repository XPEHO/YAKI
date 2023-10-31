class UserEntity {
  int? userId;
  String? lastName;
  String? firstName;
  String? email;

  UserEntity({
    required this.userId,
    required this.lastName,
    required this.firstName,
    required this.email,
  });

  @override
  String toString() {
    return "{userId: $userId, lastName: $lastName, firstName: $firstName, email: $email}";
  }
}
