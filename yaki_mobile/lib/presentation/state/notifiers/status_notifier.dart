import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';

class StatusNotifier extends StateNotifier<dynamic> {
  final DeclarationRepository declarationRepository;

  StatusNotifier(this.declarationRepository)
      : super({
          'text': '',
          'image': '',
        });

  void setState(String status) {
    state = {
      'text': '${statusMessage[status]}',
      'image': '${statusImage[status]}',
    };
  }

  String getSelectedStatus() {
    return declarationRepository.status;
  }


}
