import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/dots.svg',
          pictoPath: 'assets/images/avatar1.svg',
          headerTitle: 'Profile',
          headerHint:
              user != null ? '${user.firstName} ${user.lastName}' : 'teamMate',
        ),
        bodyContent: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              elevation: 5,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
                right: 50,
                left: 50,
              ),
            ),
            onPressed: () {
              context.go('/');
            },
            child: Text(
              tr('logOutButton'),
            ),
          ),
        ),
      ),
    );
  }
}
