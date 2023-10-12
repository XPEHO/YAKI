import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/ui/vacation/views/date_picker_popup.dart';

class VacationSelectionDialog {
  final BuildContext context;
  final Function goToPage;
  late DateTime selectedDateStart;
  late DateTime selectedDateEnd;
  final WidgetRef ref;
  final int teamId;
  VacationSelectionDialog({
    required this.context,
    required this.goToPage,
    required this.ref,
    required this.teamId,
    DateTime? selectedDateStart,
    DateTime? selectedDateEnd,
  })  : selectedDateStart = selectedDateStart ?? DateTime.now(),
        selectedDateEnd = selectedDateEnd ?? DateTime.now();
  Future<void> show() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DatePickerPopup(
          teamId: teamId,
          goToPage: goToPage,
        );
      },
    );
  }
}
