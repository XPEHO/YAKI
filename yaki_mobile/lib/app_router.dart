import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';
import 'package:yaki/presentation/ui/captain/captain_view.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/presentation/ui/declaration/morning_declaration.dart';
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
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/declaration';
                } else {
                  return '/';
                }
              },
            ),
            //GoRoute(
              //path: '/morningDeclaration',
              //builder: (context, state) => const MorningDeclaration(),
           // ),
            GoRoute(
              path: 'status',
              builder: (context, state) => const Status(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/status';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'captain',
              builder: (context, state) => const CaptainView(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/captain';
                } else {
                  return '/';
                }
              },
            ),
          ],
        ),
      ],
    );
  },
);
