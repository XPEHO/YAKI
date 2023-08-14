class LoggedUser {
  int? userId;
  int? captainId;
  int? teamMateid;
  String? lastName;
  String? firstName;
  String? email;

  LoggedUser({
    required this.userId,
    required this.captainId,
    required this.teamMateid,
    required this.lastName,
    required this.firstName,
    required this.email,
  });
}

const String incorrectLoggedIn = "";
