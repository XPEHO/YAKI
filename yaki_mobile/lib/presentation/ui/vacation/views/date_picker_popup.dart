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
  DateTimeRange selectedDateRange =
      DateTimeRange(end: DateTime.now(), start: DateTime.now());
  String selectedDateStartString = DateFormat.yMd('fr').format(DateTime.now());
  String selectedDateEndString = DateFormat.yMd('fr').format(DateTime.now());

  void validateDate(WidgetRef ref) {
    ref.watch(declarationProvider.notifier).createVacationDeclaration(
          dateStart: selectedDateRange.start,
          dateEnd: selectedDateRange.end,
          status: StatusEnum.absence.name,
          teamId: 1,
        );
    widget.goToPage();
  }

  String dateToString(DateTime date) {
    return DateFormat.yMd('fr').format(date);
  }

  Future<DateTimeRange> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      return picked;
    } else {
      return DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(tr('datePopupTitle')),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            Text(tr('datePopupHint')),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(tr('vacationDateStart')),
                    ElevatedButton(
                      onPressed: () async {
                        selectedDateRange = await _selectDate(context);
                        setState(() {
                          selectedDateStartString =
                              dateToString(selectedDateRange.start);
                          selectedDateEndString =
                              dateToString(selectedDateRange.end);
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
                    Text(tr('vacationDateEnd')),
                    ElevatedButton(
                      onPressed: () async {
                        selectedDateRange = await _selectDate(context);
                        setState(() {
                          selectedDateStartString =
                              dateToString(selectedDateRange.start);
                          selectedDateEndString =
                              dateToString(selectedDateRange.end);
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
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => validateDate(ref),
          child: const Text('OK', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
