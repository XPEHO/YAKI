import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/data/repositories/declaration_respository.dart';
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

  void setStateMorning(String status) {
    String text = StatusUtils.getTranslationKey(status);
    String image = StatusUtils.getImage(status);

    state.morning = StateStatusPage(
      image: image,
      text: tr(text),
    );
  }
}
