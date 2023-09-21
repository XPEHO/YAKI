import 'dart:io';

import 'package:dio/io.dart';
import 'package:yaki/presentation/state/dio/custom_adapter.dart';

CustomAdapter getAdapter() {
  return MobileOrientedAdapter();
}

class MobileOrientedAdapter extends CustomAdapter {
  @override
  getHttpClientAdapter() {
    return IOHttpClientAdapter(
      createHttpClient: () {
        return HttpClient()
          ..badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
      },
      validateCertificate: (certificate, host, port) {
        return true;
      },
    );
  }
}
