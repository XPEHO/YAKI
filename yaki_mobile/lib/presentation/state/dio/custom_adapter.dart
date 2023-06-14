import 'package:dio/dio.dart';
import 'package:yaki/presentation/state/dio/mobile_oriented_adapter.dart'
    if (dart.library.js) 'package:yaki/presentation/state/dio/web_oriented_adapter.dart';

abstract class CustomAdapter {
  static CustomAdapter? _instance;

  static CustomAdapter? get instance {
    _instance ??= getAdapter();
    return _instance;
  }

  HttpClientAdapter getHttpClientAdapter();
}
