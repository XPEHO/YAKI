import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/models/captain_model.dart';
import 'package:yaki/data/repositories/captain_repository.dart';

class CaptainNotifier extends StateNotifier<CaptainModel> {

  final CaptainRepository captainRepository;

  CaptainNotifier(this.captainRepository)
    :super(
    CaptainModel(
        team_mate_id: 0,
        team_mate_team_id: 0,
        team_mate_user_id: 0,
        user_id: 0,
        user_last_name: "",
        user_first_name: "",
        user_mail: "",
        user_login: "",
        user_password: "",
    ),
  );


}