class UserEntity {
  String? lastName;
  String? firstName;
  String? email;

  UserEntity({
    required this.lastName,
    required this.firstName,
    required this.email,
  });

  @override
  String toString() {
    return "{lastName: $lastName, firstName: $firstName, email: $email}";
  }
}
