import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/displaydata/declaration_status_enum.dart';
import 'package:yaki/presentation/displaydata/declaration_summary_enum.dart';
import 'package:yaki/presentation/features/absence/view/absence_header.dart';
import 'package:yaki/presentation/features/shared/app_bar_go_back.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class Absence extends ConsumerStatefulWidget {
  const Absence({super.key});

  @override
  ConsumerState<Absence> createState() => _AbsenceState();
}

class _AbsenceState extends ConsumerState<Absence> {
  void returnToTeamSelection(BuildContext context, WidgetRef ref) {
    context.go("/team-selection");
    ref.read(teamProvider.notifier).clearTeamList();
  }

  bool _isButtonActive = false;
  DateTime? _selectedDateStart;
  DateTime? _selectedDateEnd;

  /// This method is called every time the user selects a date.
  /// It checks if the selected dates are valid and if so, it enables the button.
  ///
  /// - If any of the dates is null, the button is disabled. (meaning not date has been selected)
  /// - If the start date is after the end date, the button is disabled.
  /// - If the start date is the same as the end date, the button is enabled.
  /// - If the start date is before the end date, the button is enabled.
  void _isDateValid() {
    if (_selectedDateStart == null || _selectedDateEnd == null) {
      _isButtonActive = false;
      return;
    }
    bool areDatesValid = _selectedDateStart!.isBefore(_selectedDateEnd!) ||
        _selectedDateStart == _selectedDateEnd;

    _isButtonActive = areDatesValid;
  }

  void onValidationPress() {
    final fetchedTeamList = ref.read(teamProvider).fetchedTeamList;
    //get first team with valid teamId
    final int selectedTeamId = fetchedTeamList
        .firstWhere(
          (team) => team.teamId > 0,
          orElse: () => fetchedTeamList.first,
        )
        .teamId;

    ref.watch(declarationProvider.notifier).createVacationDeclaration(
          dateStart: _selectedDateStart!,
          dateEnd: _selectedDateEnd!,
          status: StatusEnum.absence.name,
          teamId: selectedTeamId,
        );

    context.go('/summary/${DeclarationSummaryPaths.absence.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGoBack(
        onGobackIconPressed: returnToTeamSelection,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                const AbsenceHeader(),
                const SizedBox(height: 32),
                DatePickerCard(
                  title: tr('absenceStart'),
                  initialButtonLabel: tr('absenceDatePickerInitialLabel'),
                  earliestSelectableDate: DateTime.now(),
                  onDateSelection: (selectedDate) {
                    setState(() {
                      _selectedDateStart = selectedDate;
                    });
                    _isDateValid();
                  },
                  toggleLabels: [
                    tr('morning'),
                    tr('afternoon'),
                  ],
                  isTopRadius: true,
                ),
                const Divider(
                  color: kBackgroundColor,
                  thickness: 1.0,
                  height: 1,
                ),
                DatePickerCard(
                  title: tr('absenceEnd'),
                  initialButtonLabel: tr('absenceDatePickerInitialLabel'),
                  earliestSelectableDate: DateTime.now(),
                  onDateSelection: (selectedDate) {
                    setState(() {
                      _selectedDateEnd = selectedDate;
                    });
                    _isDateValid();
                  },
                  toggleLabels: [
                    tr('morning'),
                    tr('afternoon'),
                  ],
                  isTopRadius: false,
                ),
                const SizedBox(height: 70),
                Button(
                  text: tr('registrationSnackValidation').toUpperCase(),
                  buttonHeight: 58,
                  onPressed: _isButtonActive ? onValidationPress : null,
                ),
                if (!_isButtonActive)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Text(
                      tr('absenceError'),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
