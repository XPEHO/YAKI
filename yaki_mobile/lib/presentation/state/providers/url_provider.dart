import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides the API url depending on the execution platform
/// On the Web the API is the current host followed by /api
/// On mobile the API is String.fromEnvironment('API_BASE_URL') value
final urlProvider = Provider<String>((ref) {
  if (kIsWeb) {
    return '${Uri.base}/api';
  } else {
    return const String.fromEnvironment('API_BASE_URL');
  }
});
