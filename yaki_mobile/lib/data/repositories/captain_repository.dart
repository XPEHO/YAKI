import 'package:yaki/data/models/captain_model.dart';
import 'package:yaki/data/models/team_mate_model.dart';
import 'package:yaki/data/sources/captain_api.dart';

class CaptainRepository {
  final CaptainApi _captainApi;

  CaptainRepository(this._captainApi);

  Future<CaptainModel> getCaptain() async {
    final CaptainModel = await _captainApi.getCaptain() ;
    return CaptainModel;
  }

}