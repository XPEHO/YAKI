
import 'package:go_router/go_router.dart';
import 'package:yaki/presentation/ui/authentication/logged.dart';
import 'presentation/ui/authentication/Authentification.dart';

final GoRouter appRouter = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (context, state) => Authentification(),
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => logged(),
      )
    ],
);
