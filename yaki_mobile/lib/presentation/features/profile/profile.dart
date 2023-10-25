import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/features/profile/view/avatar_modal.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.read(loginRepositoryProvider).loggedUser;
    debugPrint(user.toString());

    void onLogout({required Function goToAuthentication}) {
      goToAuthentication();
    }

    void onDeleteToken({
      required WidgetRef ref,
      required Function goToAuthentication,
    }) async {
      await SharedPref.deleteToken();
      onLogout(goToAuthentication: goToAuthentication);
    }

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
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
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
                    SizedBox(
                      width: 48,
                      child: Button(
                        buttonHeight: 48,
                        onPressed: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(48),
                                topRight: Radius.circular(48),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return const AvatarModal();
                            },
                          );
                        },
                        icon: Center(
                          child: SvgPicture.asset(
                            'assets/images/edit.svg',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        text: "",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InputText(
                  type: InputTextType.email,
                  label: tr('inputLabelFirstName'),
                  controller:
                      TextEditingController(text: user?.firstName ?? ''),
                ),
                const SizedBox(height: 10),
                InputText(
                  type: InputTextType.email,
                  label: tr('inputLabelLastName'),
                  controller: TextEditingController(text: user?.lastName ?? ''),
                ),
                const SizedBox(height: 10),
                InputText(
                  type: InputTextType.email,
                  label: 'Email',
                  controller: TextEditingController(text: user?.email ?? ''),
                ),
                const SizedBox(height: 10),
                InputText(
                  type: InputTextType.password,
                  label: tr('inputPassword'),
                  controller: TextEditingController(),
                ),
                const SizedBox(height: 10),
                Button.secondary(
                  text: tr('changePassword'),
                  onPressed: () {
                    context.go('/changePassword');
                  },
                ),
                const SizedBox(height: 10),
                Button.tertiary(
                  text: tr('logOutButton'),
                  onPressed: () => onDeleteToken(
                    ref: ref,
                    goToAuthentication: () => context.go('/authentication'),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
