import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/presentation/features/shared/app_bar_date.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/features/teams_declarations_summary/view/teammates_list_async.dart';

class TeamsDeclarationSummary extends ConsumerWidget {
  const TeamsDeclarationSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarWithDate(
        actions: <Widget>[
          IconButton(
            icon: const NavIconCircleAvatar(
              imageSrc: 'assets/images/Filter.svg',
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const NavIconCircleAvatar(
              imageSrc: 'assets/images/Search.svg',
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const NavIconCircleAvatar(
              imageSrc: 'assets/images/Account.svg',
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: TeammateListAsync(),
        ),
      ),
    );
  }
}