import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/status/status.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/temp_home.dart';
import 'authentification.dart';

final GoRouter appRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const TempHome(),
      ),
      GoRoute(
        path: '/authentication',
        builder: (context, state) => const Authentification(),
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
