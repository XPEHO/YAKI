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

  /// this setState will determine the notifier state value based on the status value.
  ///
  /// Retrieve image and text matching the status.
  ///
  /// If status == "", it will set an error message when routing to the status page.
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

  /// Invoked at sign in button press in authentication page.
  ///
  /// And
  ///
  /// Invoked in declaration_body "page".
  ///
  /// Retrieve the status saved in DeclarationStatus entities;
  /// And invoke the "setState" method.
  void getSelectedStatus() {
    final String status = declarationRepository.status;
    setState(status);
  }
}
