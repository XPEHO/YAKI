import 'package:flutter/material.dart';
import 'package:yaki/presentation/features/declaration/declaration.dart';

class AfternoonDeclaration extends StatelessWidget {
  const AfternoonDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return const Declaration(
      backgroundColor: Color(0xFFF2F6F9),
      timeOfDay: 'afternoon',
      thisMorningOrAfternoon:'thisAfternoon',
      imageSrc: 'Time-Afternoon.svg',
      route: '/summaryDeclaration',
    );
  }
}
