
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/authentication/logger.dart';
import 'package:yaki/presentation/ui/authentication/Authentication.dart';

final GoRouter appRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => Authentication(),
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => logger(),
      )
    ],
);
