import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';
import 'package:yaki/presentation/ui/status/status.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/temp_home.dart';

final GoRouter appRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => const TempHome(),
      ),
      GoRoute(
        path: '/demo',
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
