import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';
import 'package:yaki/presentation/ui/status/status.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/temp_home.dart';

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) => const TempHome(),
        ),
        GoRoute(
          path: '/authentication',
          builder: (context, state) => Authentication(),
        ),
        GoRoute(
          path: '/declaration',
          builder: (context, state) => const Declaration(),
        ),
        GoRoute(
          path: '/status',
          builder: (context, state) => const Status(),
        ),
      ],
    );
  },
);
