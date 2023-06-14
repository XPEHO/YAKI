import 'package:dio/dio.dart';
import 'package:yaki/presentation/state/dio/customer_adapter_stub.dart'
    if (dart.library.io) 'package:yaki/presentation/state/dio/mobile_oriented_adapter.dart'
    if (dart.libray.js) 'package:yaki/presentation/state/dio/web_oriented_adapter.dart';

abstract class CustomAdapter {
  static CustomAdapter? _instance;

  static CustomAdapter? get instance {
    print('custom_adapter');
    _instance ??= getAdapter();
    print('customer_adapter: $_instance');
    return _instance;
  }

  HttpClientAdapter getHttpClientAdapter();
}
