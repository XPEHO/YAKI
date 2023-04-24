// GENERATED CODE - DO NOT MODIFY BY HAND
// Consider adding this file to your .gitignore.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';


import 'unit/data/repositories/team_mate_repository_test.dart' as _a;
import 'unit/data/repositories/login_repository_test.dart' as _b;
import 'unit/data/repositories/declaration_repository_test.dart' as _c;
import 'unit/data/models/user_test.dart' as _d;
import 'unit/data/models/login_model_test.dart' as _e;
import 'unit/data/models/declaration_model_test.dart' as _f;
import 'unit/data/models/team_mate_model_test.dart' as _g;
import 'unit/data/models/declaration_model_in_test.dart' as _h;
import 'unit/data/sources/local/shared_preference_test.dart' as _i;
import 'unit/presentation/state/notifiers/declaration_notifier_test.dart' as _j;
import 'widget_test.dart' as _k;

void main() {
  goldenFileComparator = _TestOptimizationAwareGoldenFileComparator();
  group('unit/data/repositories/team_mate_repository_test.dart', () { _a.main(); });
  group('unit/data/repositories/login_repository_test.dart', () { _b.main(); });
  group('unit/data/repositories/declaration_repository_test.dart', () { _c.main(); });
  group('unit/data/models/user_test.dart', () { _d.main(); });
  group('unit/data/models/login_model_test.dart', () { _e.main(); });
  group('unit/data/models/declaration_model_test.dart', () { _f.main(); });
  group('unit/data/models/team_mate_model_test.dart', () { _g.main(); });
  group('unit/data/models/declaration_model_in_test.dart', () { _h.main(); });
  group('unit/data/sources/local/shared_preference_test.dart', () { _i.main(); });
  group('unit/presentation/state/notifiers/declaration_notifier_test.dart', () { _j.main(); });
  group('widget_test.dart', () { _k.main(); });
}


class _TestOptimizationAwareGoldenFileComparator extends LocalFileComparator {
  final List<String> goldenFilePaths;

  _TestOptimizationAwareGoldenFileComparator()
      : goldenFilePaths = _goldenFilePaths,
        super(_testFile);

  static Uri get _testFile {
    final basedir =
        (goldenFileComparator as LocalFileComparator).basedir.toString();
    return Uri.parse("$basedir/.test_optimizer.dart");
  }

  static List<String> get _goldenFilePaths =>
      Directory.fromUri((goldenFileComparator as LocalFileComparator).basedir)
          .listSync(recursive: true, followLinks: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((path) => path.endsWith('.png'))
          .toList();

  @override
  Uri getTestUri(Uri key, int? version) {
    final keyString = key.path;
    return Uri.parse(goldenFilePaths
        .singleWhere((goldenFilePath) => goldenFilePath.endsWith(keyString)));
  }
}
