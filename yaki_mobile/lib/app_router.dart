import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/displaydata/declaration_enum.dart';
import 'package:yaki/presentation/features/authentication/authentication.dart';
import 'package:yaki/presentation/features/declaration/temp_page.dart';
import 'package:yaki/presentation/features/team_selection/team_selection.dart';
import 'package:yaki/presentation/ui/password/forgot_password.dart';
import 'package:yaki/presentation/ui/captain/captain_view.dart';
import 'package:yaki/presentation/ui/default/user_default_redirection.dart';
import 'package:yaki/presentation/ui/password/change_password.dart';
import 'package:yaki/presentation/ui/profile/profile.dart';
import 'package:yaki/presentation/ui/registration/registration.dart';
import 'package:yaki/presentation/ui/status/status_recap_halfday.dart';
import 'package:yaki/presentation/ui/status/status_recap_fullday.dart';
import 'package:yaki/presentation/ui/status/vacation_status.dart';

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
              path: 'vacationStatus',
              builder: (context, state) => const VacationStatus(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/vacationStatus';
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
            ),
            GoRoute(
              path: 'userDefaultRedirection',
              builder: (context, state) => const UserDefaultRedirection(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/userDefaultRedirection';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'changePassword',
              builder: (context, state) => const ChangePassword(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/changePassword';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'team-selection',
              builder: (context, state) => const TeamSelection(),
              redirect: (BuildContext context, GoRouterState state) async {
                if (await SharedPref.isTokenPresent()) {
                  return '/team-selection';
                } else {
                  return '/';
                }
              },
            ),
            GoRoute(
              path: 'declaration/:mode',
              builder: (context, state) => TempDeclarationPage(
                declarationMode: state.pathParameters['mode']!,
              ),
              redirect: (BuildContext context, GoRouterState state) async {
                // null check
                final String pathParam = state.pathParameters['mode'] ?? '';
                // check if the path parameter is valid
                final bool isValidPath =
                    DeclarationPaths.isValidPath(value: pathParam);

                if (await SharedPref.isTokenPresent() && isValidPath) {
                  return '/declaration/${state.pathParameters['mode']!}';
                }
                return '/';
              },
            ),
          ],
        ),
        GoRoute(
          path: '/registration',
          builder: (context, state) => const Registration(),
        ),
        GoRoute(
          path: '/forgotPassword',
          builder: (context, state) => const ForgotPassword(),
        ),
      ],
    );
  },
);
