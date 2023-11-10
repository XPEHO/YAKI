import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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

    final isAlreadyDeclared = ref.watch(declarationProvider).isAlreadyDeclared;
    print(isAlreadyDeclared);
    // Future<bool> getIsDeclared() async {
    //   return await ref
    //       .read(declarationProvider.notifier)
    //       .getLatestDeclaration();
    // }

    // return FutureBuilder<bool>(
    //   future: getIsDeclared(),
    //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const CircularProgressIndicator(); // or some other widget while waiting for data
    //     } else {
    //       final isDeclared = snapshot.data ?? false;
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
