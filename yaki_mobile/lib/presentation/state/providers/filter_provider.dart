import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/filter_entity.dart';
import 'package:yaki/presentation/state/notifiers/filter_notifier.dart';

final filterProvider = StateNotifierProvider<FilterNotifier, FilterEntity>(
  (ref) => FilterNotifier(),
);
