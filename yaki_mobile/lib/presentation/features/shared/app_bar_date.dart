import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yaki/presentation/styles/text_style.dart';

class AppBarWithDate extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;

  const AppBarWithDate({super.key, this.actions});

  @override
  Widget build(BuildContext context) {
    final toDayDate = DateFormat('d MMMM y').format(DateTime.now());

    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
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
