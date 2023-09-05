class LoggedUser {
  int? userId;
  int? captainId;
  int? teammateId;
  String? lastName;
  String? firstName;
  String? email;

  LoggedUser({
    required this.userId,
    required this.captainId,
    required this.teammateId,
    required this.lastName,
    required this.firstName,
    required this.email,
  });

  @override
  String toString() {
    return "{userId: $userId, captainId: $captainId, teammateid: $teammateId, lastName: $lastName, firstName: $firstName, email: $email}";
  }
}

const String incorrectLoggedIn = "";
