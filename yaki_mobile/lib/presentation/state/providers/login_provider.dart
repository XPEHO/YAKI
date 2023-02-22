import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/state/login_state.dart';
import 'package:yaki/presentation/state/notifiers/login_notifier.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());