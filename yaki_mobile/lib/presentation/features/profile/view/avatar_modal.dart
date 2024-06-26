import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/features/shared/sized_circle_avatar.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:image/image.dart' as img;

class AvatarModal extends ConsumerStatefulWidget {
  const AvatarModal({super.key});

  @override
  AvatarModalState createState() => AvatarModalState();
}

class AvatarModalState extends ConsumerState<AvatarModal> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    Future<void> pickImage(ImageSource source) async {
      setState(() {
        _imageFile = null;
      });

      final pickedFile = await ImagePicker().pickImage(
        source: source,
        maxHeight: 640,
        maxWidth: 480,
        imageQuality: 50,
      );

      if (pickedFile != null) {
        final originalImage = img.decodeImage(await pickedFile.readAsBytes());

        final directory = await getApplicationDocumentsDirectory();
        final path = directory.path;
        final File resizedImageFile = File('$path/resized_image.jpg')
          ..writeAsBytesSync(img.encodeJpg(originalImage!));

        setState(() {
          _imageFile = resizedImageFile;
        });
      }
    }

    void uploadImage(
      String avatarReference,
      File? fileName,
      Function closeModal,
    ) async {
      await ref.read(avatarProvider.notifier).postAvatar(
            avatarReference,
            fileName,
          );
      closeModal();
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
                    onTap: () => uploadImage(
                      'avatarNone',
                      null,
                      () => Navigator.of(context).pop(),
                    ),
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
                    onTap: () => uploadImage(
                      'avatarN',
                      null,
                      () => Navigator.of(context).pop(),
                    ),
                    child: const ProfilAvatarSvg(
                      imageSrc: 'assets/images/Avatar.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => uploadImage(
                      'avatarF',
                      null,
                      () => Navigator.of(context).pop(),
                    ),
                    child: const ProfilAvatarSvg(
                      imageSrc: 'assets/images/avatar-woman.svg',
                    ),
                  ),
                  InkWell(
                    onTap: () => uploadImage(
                      'avatarH',
                      null,
                      () => Navigator.of(context).pop(),
                    ),
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
                  //check if the app is running on the web
                  if (!kIsWeb)
                    Button.secondary(
                      text: tr('takePicture').toUpperCase(),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                    ),
                  const SizedBox(height: 10),
                  kIsWeb
                      ? const SizedBox.shrink()
                      : Button.secondary(
                          text: tr('imgGallery').toUpperCase(),
                          onPressed: () => pickImage(ImageSource.gallery),
                        ),
                  const SizedBox(height: 10),
                  if (_imageFile != null)
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          100.0,
                        ), // adjust the radius as needed
                        child: Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  if (_imageFile != null)
                    Text(
                      '${tr("imageSize")} ${(_imageFile!.lengthSync() / 1024).toStringAsFixed(2)} kb',
                    ),
                  const SizedBox(height: 20),
                  if (_imageFile != null)
                    Button(
                      text: tr('upload').toUpperCase(),
                      onPressed: () => uploadImage(
                        'userPicture',
                        _imageFile,
                        () => Navigator.of(context).pop(),
                      ),
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
