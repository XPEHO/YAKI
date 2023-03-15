import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/captain_model.dart';
import 'package:yaki/data/repositories/captain_repository.dart';

class CaptainNotifier extends StateNotifier<CaptainModel> {
  final CaptainRepository captainRepository;

  CaptainNotifier(this.captainRepository)
      : super(
          CaptainModel(
            teamMateId: 0,
            teamMateTeamId: 0,
            teamMateUserId: 0,
            userId: 0,
            userLastName: "",
            userFirstName: "",
            userMail: "",
            userLogin: "",
            userPassword: "",
          ),
        );
}
