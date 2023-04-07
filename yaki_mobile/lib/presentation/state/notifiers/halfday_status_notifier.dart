import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/status_page_content.dart';
import 'package:yaki/presentation/state/state/state_halfday_page.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

class HalfdayStatusNotifier extends StateNotifier<StateHalfdayPage> {
  final DeclarationRepository declarationRepository;

  HalfdayStatusNotifier(this.declarationRepository)
      : super(
          StateHalfdayPage(
            morning: StateStatusPage(
              image: 'assets/images/unknown.svg',
              text: '...',
            ),
            afternoon: StateStatusPage(
              image: 'assets/images/unknown.svg',
              text: '...',
            ),
          ),
        );

  /// set state declaration for the morning
  void setStateMorning(String status) {
    String text = StatusUtils.getTranslationKey(status, 'Morning');
    String image = StatusUtils.getImage(status);

    state.morning = StateStatusPage(
      image: image,
      text: tr(text),
    );
  }

  /// set state declaration for the afternoon
  void setStateAfternoon(String status) {
    String text = StatusUtils.getTranslationKey(status, 'Afternoon');
    String image = StatusUtils.getImage(status);

    state.afternoon = StateStatusPage(
      image: image,
      text: tr(text),
    );
  }

  /// method that retreives declaration for the afternoon and morning from
  /// declarationRepository, and store them in a state
  void getHalfdayDeclaration() {
    final DeclarationStatus declarations =
        declarationRepository.allDeclarations;
    setStateMorning(declarations.morningDeclaration);
    setStateAfternoon(declarations.afternoonDeclaration);
  }
}
