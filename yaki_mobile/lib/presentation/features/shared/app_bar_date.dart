import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class AppBarWithDate extends ConsumerWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarWithDate({Key? key, this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDayDate = DateFormat('d MMMM y').format(DateTime.now());
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final showBackButton = currentRoute == 'team-selection';

    final latestDeclarationStatus =
        ref.watch(declarationProvider).latestDeclarationStatus;
    final isAlreadyDeclared =
        latestDeclarationStatus == LatestDeclarationStatus.declared;

    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: showBackButton && isAlreadyDeclared,
      leading: showBackButton && isAlreadyDeclared
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go('/teams-declaration-summary'),
            )
          : null,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          toDayDate,
          style: textStylePageDate(),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
