import 'package:flutter_test/flutter_test.dart';
import 'package:yaki/domain/entities/declaration_status.dart';

void main() {
  test('Declaration status', () async {
    DeclarationStatus status = DeclarationStatus();

    expect(
      status.toString(),
      'DeclarationStatus{fullDayStatus: , morningStatus: , afternoonStatus: }',
    );

    status.fullDayStatus = 'fullDayStatus';
    status.morningStatus = 'morningStatus';

    expect(
      status.toString(),
      'DeclarationStatus{fullDayStatus: fullDayStatus, morningStatus: morningStatus, afternoonStatus: }',
    );
  });
}
