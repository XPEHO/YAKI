import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/ui/authentication/authentication.dart';
import 'package:yaki/presentation/ui/captain/captain_view.dart';
import 'package:yaki/presentation/ui/declaration/declaration.dart';
import 'package:yaki/presentation/ui/declaration/afternoon_declaration.dart';
import 'package:yaki/presentation/ui/declaration/morning_declaration.dart';
import 'package:yaki/presentation/ui/profile/profile.dart';
import 'package:yaki/presentation/ui/registration/registration.dart';
import 'package:yaki/presentation/ui/status/status_recap_halfday.dart';
import 'package:yaki/presentation/ui/status/status_recap_fullday.dart';

/// router set as provider.
final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) => const Authentication(),
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
            GoRoute(
              path: 'morningDeclaration',
              builder: (context, state) => const MorningDeclaration(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/morningDeclaration';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'afternoonDeclaration',
              builder: (context, state) => const AfternoonDeclaration(),
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const AfternoonDeclaration(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ),
                  ),
                  child: child,
                ),
                transitionDuration: const Duration(milliseconds: 200),
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/afternoonDeclaration';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'status',
              builder: (context, state) => const StatusRecapFullDay(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/status';
                } else {
                  return '/declaration';
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
            GoRoute(
              path: 'halfdayStatus',
              builder: (context, state) => const StatusRecapHalfDay(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/halfdayStatus';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const Profile(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/profile';
                } else {
                  return '/';
                }
              },
            )
          ],
        ),
        GoRoute(
          path: '/registration',
          builder: (context, state) => const Registration(),
        ),
      ],
    );
  },
);
