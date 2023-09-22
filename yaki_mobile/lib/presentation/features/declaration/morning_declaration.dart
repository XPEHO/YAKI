import 'package:flutter/material.dart';
import 'package:yaki/presentation/features/declaration/declaration.dart';

class MorningDeclaration extends StatelessWidget {
  const MorningDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    return const Declaration(
      backgroundColor: Color(0xFFF2F6F9),
      timeOfDay: 'morning',
      thisMorningOrAfternoon: 'this',
      imageSrc: 'Time-Morning.svg',
      route: '/afternoonDeclaration',
    );
  }
}
