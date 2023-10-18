import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil-men.svg'),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil-men2.svg'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil-woman.svg'),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil-absent.svg'),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil-damier.svg'),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(''),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // Take a photo
              },
              child: tr('takePicture'),
            ),
            ElevatedButton(
              onPressed: () {
                // Choose from gallery
              },
              child: tr('imgGallery'),
            ),
          ],
        ),
      ],
    );
  }
}
