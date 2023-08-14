import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

class VacationSelectionDialog {
  final BuildContext context;
  final Function goToPage;
  late DateTime selectedDateStart;
  late DateTime selectedDateEnd;
  final WidgetRef ref;
  VacationSelectionDialog({
    required this.context,
    required this.goToPage,
    required this.ref,
    DateTime? selectedDateStart,
    DateTime? selectedDateEnd,
  })  : selectedDateStart = selectedDateStart ?? DateTime.now(),
        selectedDateEnd = selectedDateEnd ?? DateTime.now();
void validateDate(WidgetRef ref){
  ref.watch(declarationProvider.notifier).createVacationDeclaration(
                      dateStart: selectedDateStart,
                      dateEnd: selectedDateEnd,
                      status: StatusEnum.vacation.name,
                      teamId: 1,
                      );
                      goToPage();
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
    }
    else{
      return DateTime.now();
    }
  }
  Future<void> show() async{
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
                    onPressed: () async => selectedDateStart = await _selectDate(context),
                    child: Text(
                      selectedDateStart.toString() ?? DateTime.now().toString(),
                    ),
                  ),
                    ],
                    ),
                    Column(
                    children: [
                      const Text('Ending Date'),
                     ElevatedButton(
                    onPressed: () async => selectedDateEnd = await _selectDate(context),
                    child: Text(selectedDateEnd.toString() ?? DateTime.now().toString(),
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
        ),
    );
  } 
}