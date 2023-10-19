import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class AvatarModal extends ConsumerWidget {
  const AvatarModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profil-men.svg'),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profil-men2.svg'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profil-woman.svg'),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profil-absent.svg'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage('assets/images/profil-damier.svg'),
                          ),
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: const Color(0xFFFFD7C0),
                            child: Text(
                              '${user?.firstName?[0]}${user?.lastName?[0]}',
                              style: const TextStyle(
                                color: Color(0xFF7D818C),
                                fontSize: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 4),
                            child: Button.secondary(
                              text: tr('takePicture'),
                              onPressed: () {},
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 4),
                            child: Button.secondary(
                              text: tr('imgGallery'),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: null,
        ),
      ],
    );
  }
}
