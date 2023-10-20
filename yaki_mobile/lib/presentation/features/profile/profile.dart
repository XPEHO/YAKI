import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/features/profile/view/avatar_modal.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.go('/teams-declaration-summary');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                SizedBox(
                  height: 160,
                  width: 160,
                  child: SvgPicture.asset(
                    'assets/images/avatar-men.svg',
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF936B),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const AvatarModal();
                          },
                        );
                      },
                      icon: SvgPicture.asset(
                        'assets/images/edit.svg',
                        height: 20,
                        width: 20,
                      ),
                      label: const Text(''),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: InputText(
                type: InputTextType.firstname,
                label: tr('inputLabelFirstName'),
                controller: TextEditingController(text: user?.firstName ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: InputText(
                type: InputTextType.lastname,
                label: tr('inputLabelLastName'),
                controller: TextEditingController(text: user?.lastName ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: InputText(
                type: InputTextType.email,
                label: 'Email',
                controller: TextEditingController(text: user?.email ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: InputText(
                type: InputTextType.password,
                label: tr('inputPassword'),
                controller: TextEditingController(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: Button.secondary(
                text: tr('changePassword'),
                onPressed: () {
                  context.go('/changePassword');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
              child: Button.tertiary(
                text: tr('logOutButton'),
                onPressed: () {
                  context.go('/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
