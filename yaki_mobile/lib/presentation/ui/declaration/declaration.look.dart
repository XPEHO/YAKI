// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// LookGenerator
// **************************************************************************

import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:look/look.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/presentation/ui/declaration/views/declaration_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout_declaration.dart';
import 'package:yaki/presentation/ui/shared/views/header_declaration.dart';

void main() => runApp(const LookDeclarationApp());

class LookDeclarationApp extends StatelessWidget {
  const LookDeclarationApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Looking Declaration',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: buildDeclarationLook(),
      );
}
