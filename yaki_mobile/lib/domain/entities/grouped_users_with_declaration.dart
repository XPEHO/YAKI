import 'package:yaki/domain/entities/teammate_with_declaration_entity.dart';

class GroupedUserWithDeclaration {
  final List<TeammateWithDeclarationEntity> me;
  final List<TeammateWithDeclarationEntity> myCoworkers;
  final List<TeammateWithDeclarationEntity> absent;
  final List<TeammateWithDeclarationEntity> notDeclared;

  GroupedUserWithDeclaration({
    required this.me,
    required this.myCoworkers,
    required this.absent,
    required this.notDeclared,
  });

  @override
  String toString() {
    return "me: $me, myCoworkers: $myCoworkers, absent: $absent, notDeclared: $notDeclared";
  }
}
