import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/state/state_halfday_page.dart';
import 'package:yaki/presentation/state/state/state_status_page.dart';

class HalfdayStatusNotifier extends StateNotifier<StateHalfdayPage> {
  final Ref ref;

  HalfdayStatusNotifier(this.ref)
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
    String text =
        StatusUtils.getTranslationKey(status, StatusEnum.morning.value);
    String imageCamelCase = StatusUtils.toCamelCase(toFormat: status);
    String image = StatusUtils.getImage(imageCamelCase);

    state.morning = StateStatusPage(
      image: image,
      text: tr(text),
    );
  }

  /// set state declaration for the afternoon
  void setStateAfternoon(String status) {
    String text =
        StatusUtils.getTranslationKey(status, StatusEnum.afternoon.value);
    String imageCamelCase = StatusUtils.toCamelCase(toFormat: status);
    String image = StatusUtils.getImage(imageCamelCase);

    state.afternoon = StateStatusPage(
      image: image,
      text: tr(text),
    );
  }

  /// method that retreives declaration for the afternoon and morning from
  /// declarationRepository, and store them in a state
  void setStatusRecapHalfDayContent() {
    final DeclarationStatus declarationStatus = ref.read(declarationProvider);
    // setStateMorning(declarationStatus.morningStatus);
    // setStateAfternoon(declarationStatus.afternoonStatus);

    setStateMorning(declarationStatus.fullDayStatus);
    setStateAfternoon(declarationStatus.fullDayStatus);
  }
}
