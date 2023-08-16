import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

class DatePickerPopup extends ConsumerStatefulWidget {
  final Function goToPage;
  const DatePickerPopup({super.key, required this.goToPage});

  @override
  ConsumerState<DatePickerPopup> createState() => _DatePickerPopupState();
}

class _DatePickerPopupState extends ConsumerState<DatePickerPopup> {
  DateTime selectedDateStart = DateTime.now();
  DateTime selectedDateEnd = DateTime.now();
  String selectedDateStartString = '';
  String selectedDateEndString = '';

  void validateDate(WidgetRef ref) {
    ref.watch(declarationProvider.notifier).createVacationDeclaration(
          dateStart: selectedDateStart,
          dateEnd: selectedDateEnd,
          status: StatusEnum.vacation.name,
          teamId: 1,
        );
    widget.goToPage();
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked;
    } else {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vacation Selection Date'),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            const Text('Please select the date of your vacation'),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Start Date'),
                    ElevatedButton(
                      onPressed: () async {
                        selectedDateStart = await _selectDate(context);
                        setState(() {
                          selectedDateStartString =
                              DateFormat.yMd('fr').format(selectedDateStart);
                        });
                      },
                      child: Text(
                        selectedDateStartString,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text('Ending Date'),
                    ElevatedButton(
                      onPressed: () async {
                        selectedDateEnd = await _selectDate(context);
                        setState(() {
                          selectedDateEndString =
                              DateFormat.yMd('fr').format(selectedDateEnd);
                        });
                      },
                      child: Text(
                        selectedDateEndString,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop('cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => validateDate(ref),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
