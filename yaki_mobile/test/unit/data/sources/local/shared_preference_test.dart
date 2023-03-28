import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  SharedPreferences.setMockInitialValues(
    {
      'token': '',
      'userId': '',
    },
  );

  group(
    'sharedPreference function test',
    () {},
  );
}
