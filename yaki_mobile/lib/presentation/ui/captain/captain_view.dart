import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/ui/captain/views/captain_body.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';

class CaptainView extends ConsumerWidget {
  const CaptainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/captain.svg',
          pictoPath: 'assets/images/captain.svg',
          headerTitle: tr('captainHeaderTitle'),
          headerHint:
              user != null ? '${user.firstName} ${user.lastName}' : 'captain',
          onPressed: () {
            context.push('/profile');
          },
        ),
        bodyContent: const CaptainBody(),
      ),
    );
  }
}
