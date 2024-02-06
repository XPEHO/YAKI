import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarGoBack extends ConsumerWidget implements PreferredSizeWidget {
  final void Function(BuildContext, WidgetRef) onGobackIconPressed;

  const AppBarGoBack({super.key, required this.onGobackIconPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => onGobackIconPressed(context, ref),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
