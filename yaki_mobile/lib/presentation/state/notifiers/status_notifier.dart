import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

class StatusPageNotifier extends StateNotifier<StateStatusPage> {
  final DeclarationRepository declarationRepository;

  StatusPageNotifier(this.declarationRepository)
      : super(
          StateStatusPage(
            image: 'assets/images/unknown.svg',
            text: '...',
          ),
        );

  /// this setState will determine the notifier state value based on the status value.
  ///
  /// Retrieve image and text matching the status.
  ///
  /// Functions from status_page_content will determine which text & image will be displayed.
  void setState(String status) {
    String text = StatusUtils.getTranslationKey(status);
    String image = StatusUtils.getImage(status);

    state = StateStatusPage(
      image: image,
      text: tr(text),
    );
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
    final String status = declarationRepository.statusAllDay;
    setState(status);
  }

  void getMorningStatus() {
    final String status = declarationRepository.statusMorning;
    setState(status);
  }
}
