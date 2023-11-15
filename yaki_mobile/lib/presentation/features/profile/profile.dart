import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/user_entity.dart';
import 'package:yaki/presentation/displaydata/avatar_enum.dart';
import 'package:yaki/presentation/features/profile/view/avatar_modal.dart';
import 'package:yaki/presentation/features/shared/feedback_user.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/user_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key, required String from});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserEntity? user = ref.watch(userProvider);
    final ScrollController scrollController = ScrollController();

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

    Future<String> getPassword() async {
      List<String> loginDetails = await SharedPref.getLoginDetails();
      return loginDetails[1];
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: FutureBuilder<String>(
                future: getPassword(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SizedBox(
                              height: 160,
                              width: 160,
                              child: changeAvatarImage(ref),
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
                                    'assets/images/Edit.svg',
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
                          controller: TextEditingController(
                            text: user?.firstName ?? '',
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        InputText(
                          type: InputTextType.email,
                          label: tr('inputLabelLastName'),
                          controller:
                              TextEditingController(text: user?.lastName ?? ''),
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        InputText(
                          type: InputTextType.email,
                          label: 'Email',
                          controller:
                              TextEditingController(text: user?.email ?? ''),
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        InputText(
                          type: InputTextType.password,
                          label: tr('inputPassword'),
                          controller:
                              TextEditingController(text: snapshot.data ?? ''),
                          readOnly: true,
                        ),
                        const SizedBox(height: 10),
                        Button.secondary(
                          text: tr('changePassword').toUpperCase(),
                          onPressed: () {
                            context.go('/changePassword');
                          },
                        ),
                        const SizedBox(height: 10),
                        Button.tertiary(
                          text: tr('logOutButton').toUpperCase(),
                          onPressed: () => onDeleteToken(
                            ref: ref,
                            goToAuthentication: () =>
                                context.go('/authentication'),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const FeedbackUser(),
                        const SizedBox(height: 40),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget changeAvatarImage(WidgetRef ref) {
  final avatarData = ref.watch(avatarProvider);
  final UserEntity? user = ref.watch(userProvider);

  if (avatarData.avatarReference != null &&
      avatarData.avatarReference != "avatarNone") {
    return SvgPicture.asset(
      AvatarEnum.values.byName(avatarData.avatarReference!).text,
    );
  } else if (avatarData.avatarReference == null && avatarData.avatar != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        100.0,
      ), // adjust the radius as needed
      child: Image.memory(avatarData.avatar!),
    );
  } else {
    return CircleAvatar(
      radius: 60,
      backgroundColor: const Color(0xFFFFD7C0),
      child: Text(
        '${(user?.firstName != null && user!.firstName!.isNotEmpty) ? user.firstName![0] : "A"}${(user?.lastName != null && user!.lastName!.isNotEmpty) ? user.lastName![0] : "B"}',
        style: const TextStyle(
          color: Color(0xFF7D818C),
          fontSize: 40,
        ),
      ),
    );
  }
}
