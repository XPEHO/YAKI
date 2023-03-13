import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/declaration_card_content.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

class StatusPageNotifier extends StateNotifier<StateStatusPage> {
  final DeclarationRepository declarationRepository;

  StatusPageNotifier(this.declarationRepository)
      : super(
          StateStatusPage(
            image: 'assets/images/unknown.svg',
            text: 'default message',
          ),
        );

  void setState(String status) {
    if (status != "") {
      state = StateStatusPage(
        image: '${statusImage[status]}',
        text: tr('${statusMessage[status]}'),
      );
    } else {
      state = StateStatusPage(
        image: 'assets/images/unknown.svg',
        text: tr("StatusError"),
      );
    }
  }

  void getSelectedStatus() {
    final String status = declarationRepository.status;
    setState(status);
  }
}
