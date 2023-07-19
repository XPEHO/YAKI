import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:look/look.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki/presentation/ui/shared/views/avatar_icon.dart';

@Look(builder: buildHeaderLook)
class HeaderDeclaration extends StatelessWidget {
  final String pictoIcon;
  final String pictoPath;
  final String pictoSwitch;
  final String headerTitle;
  final String headerHint;

  const HeaderDeclaration({
    super.key,
    required this.pictoIcon,
    required this.pictoPath,
    required this.pictoSwitch,
    required this.headerTitle,
    required this.headerHint,
  });

  /// Called when the picto switch button is tapped.
  /// Checks the current route and navigates to the corresponding route.
  void onPictoSwitchTap(BuildContext context) {
    // Check if the current route is either the 'morningDeclaration'
    // or 'afternoonDeclaration' route
    if ((ModalRoute.of(context)?.settings.name == 'morningDeclaration') ||
        (ModalRoute.of(context)?.settings.name == 'afternoonDeclaration')) {
      // If so, navigate to the 'declaration' route
      context.go('/declaration');
    } else {
      // Otherwise, navigate to the 'morningDeclaration' route
      context.go('/morningDeclaration');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraint) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: AppColors.yakiPrimaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 4,
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        headerTitle,
                        style: textStyleHeaderBig(),
                      ),
                      const Spacer(),
                      // top right circle avatar
                      AvatarIcon(
                        pictoIcon: pictoIcon,
                        onPressed: () => {
                          context.push('/profile'),
                        },
                      ),
                    ],
                  ),
                  constraint.maxWidth < 350
                      ? Logo(
                          pictoPath: pictoPath,
                          pictoSwitch: pictoSwitch,
                          onPictoSwitchTap: onPictoSwitchTap,
                          size: 130.0,
                        )
                      : Logo(
                          pictoPath: pictoPath,
                          pictoSwitch: pictoSwitch,
                          onPictoSwitchTap: onPictoSwitchTap,
                          size: 200.0,
                        ),
                  SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        headerHint,
                        style: constraint.maxWidth < 350
                            ? textStyleHeaderSmall()
                            : textStyleHeaderBig(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Logo extends StatelessWidget {
  final String pictoPath;
  final String pictoSwitch;
  final Function onPictoSwitchTap;
  final double size;

  const Logo({
    super.key,
    required this.pictoPath,
    required this.pictoSwitch,
    required this.onPictoSwitchTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: SvgPicture.asset(
              pictoPath,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Material(
                elevation: 15,
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 231, 230, 227),
                      border: Border.all(
                        color: const Color.fromARGB(255, 228, 146, 31),
                        width: 4.0,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(139, 54, 30, 8),
                          offset: Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 15.0,
                          spreadRadius: 2.8,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    width: 72,
                    height: 72,
                    child: Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          onTap: () => onPictoSwitchTap(context),
                          child: SvgPicture.asset(
                            pictoSwitch,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleAvatarPNG extends StatelessWidget {
  final String iconPath;
  final double radius;

  const CircleAvatarPNG({
    super.key,
    required this.iconPath,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage(iconPath),
      radius: radius,
    );
  }
}

buildHeaderLook() => const HeaderDeclaration(
      pictoIcon: 'assets/images/avatar1.svg',
      pictoPath: 'assets/images/day.svg',
      pictoSwitch: 'assets/images/pm.svg',
      headerTitle: 'header title',
      headerHint: 'header hint',
    );
