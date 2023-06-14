import 'package:dio/browser.dart';
import 'package:yaki/presentation/state/dio/custom_adapter.dart';

CustomAdapter getAdapter() {
  return WebOrientedAdapter();
}

class WebOrientedAdapter extends CustomAdapter {
  @override
  getHttpClientAdapter() {
    return BrowserHttpClientAdapter();
  }
}
