import 'package:go_router/go_router.dart';

import 'Authentification.dart';

final GoRouter appRouter = GoRouter(routes: <GoRoute>[
  GoRoute(
    path: '/',
    builder: (context, state) => Authentification(),
    routes: const [],
  )
]);
