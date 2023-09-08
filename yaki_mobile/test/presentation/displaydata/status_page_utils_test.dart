import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/presentation/displaydata/status_page_utils.dart';

void main() {
  test('Status page utils ...', () async {
    String enumValue = 'remote';
    String result = StatusEnum.getValue(key: enumValue);

    expect(
      result,
      StatusEnum.remote.value,
    );
  });

  test('to Camel case', () async {
    String result = StatusUtils.toCamelCase(toFormat: 'Hello World');

    expect(
      result,
      'helloWorld',
    );
  });

  test('get Image of status', () {
    String extensionsFile = '.svg';

    String resultValue = StatusUtils.getImage(StatusEnum.remote.value);
    String resultUndeclared = StatusUtils.getImage(StatusEnum.undeclared.value);

    expect(
      resultValue,
      'assets/images/remote$extensionsFile',
    );

    expect(
      resultUndeclared,
      'assets/images/unknown$extensionsFile',
    );
  });

  test('get Translations Key', () {
    String resulltMorningMode = StatusUtils.getTranslationKey(
      StatusEnum.remote.value,
      StatusEnum.morningTr.value,
    );

    String resultError = StatusUtils.getTranslationKey(
      '',
      StatusEnum.morningTr.value,
    );

    expect(
      resulltMorningMode,
      'statusRemoteMorning',
    );

    expect(
      resultError,
      'StatusError',
    );
  });
}
