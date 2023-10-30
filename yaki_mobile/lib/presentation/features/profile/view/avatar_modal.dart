import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

class AvatarModal extends ConsumerWidget {
  const AvatarModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    Future<void> takePicture() async {
      final imageFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (imageFile != null) {
        // Do something with the image file
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // This is a modal bottom sheet. This need to be delete when the method will be implemented
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Coming soon'),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: const Color(0xFFFFD7C0),
                      child: Text(
                        '${user?.firstName?[0] ?? "A"}${user?.lastName?[0] ?? "B"}',
                        style: const TextStyle(
                          color: Color(0xFF7D818C),
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // This is a modal bottom sheet. This need to be delete when the method will be implemented
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Coming soon'),
                            ),
                          );
                        },
                      );
                    },
                    child: const ProfilAvatarSvg(
                      imageSrc: 'assets/images/avatar-men2.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // This is a modal bottom sheet. This need to be delete when the method will be implemented
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Coming soon'),
                            ),
                          );
                        },
                      );
                    },
                    child: const ProfilAvatarSvg(
                      imageSrc: 'assets/images/avatar-woman.svg',
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // This is a modal bottom sheet. This need to be delete when the method will be implemented
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Coming soon'),
                            ),
                          );
                        },
                      );
                    },
                    child: const ProfilAvatarSvg(
                      imageSrc: 'assets/images/avatar-men.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button.secondary(
                    text: tr('takePicture'),
                    onPressed: takePicture,
                  ),
                  const SizedBox(height: 10),
                  Button.secondary(
                    text: tr('imgGallery'),
                    onPressed: () {
                      // This is a modal bottom sheet. This need to be delete when the method will be implemented
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: Text('Coming soon'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
