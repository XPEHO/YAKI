import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';
import 'package:yaki/presentation/ui/captain/captain_view.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/presentation/ui/status/status.dart';

/// router set as provider.
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) => Authentication(),
          routes: [
            GoRoute(
              path: 'declaration',
              builder: (context, state) => const Declaration(),
            ),
            GoRoute(
              path: 'status',
              builder: (context, state) => const Status(),
            ),
            GoRoute(
              path: 'captain',
              builder: (context, state) => const CaptainView(),
            ),
          ],
        ),
      ],
    );
  },
);
