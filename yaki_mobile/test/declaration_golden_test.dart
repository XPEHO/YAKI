import 'package:look/look.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';

part 'declaration_golden_test.lookgolden.dart';

@LookGolden(
  type: Declaration,
  builder: buildDeclarationLook,
  name: 'goldens/declaration_golden.png',
  dimensions: ['400x600', '800x600', '800x1200', '1600x1200'],
)
main() => lookGoldens();
