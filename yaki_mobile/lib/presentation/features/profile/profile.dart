import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/user_entity.dart';
import 'package:yaki/presentation/displaydata/avatar_enum.dart';
import 'package:yaki/presentation/features/profile/view/avatar_modal.dart';
import 'package:yaki/presentation/features/shared/feedback_user.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/user_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:yaki/channels.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> with WidgetsBindingObserver {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

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

  /// Callback for the swap button
  void onSwapChangeCallback(bool value) {
    debugPrint('onSwapChangeCallback');
    debugPrint('value: $value');
    if (value) {
      scheduleNotifications();
    } else {
      cancelNotifications();
    }
    setNotificationsActivationState(value);
  }

  @override
  Widget build(BuildContext context) {
    final UserEntity? user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
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
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 48,
                                child: FutureBuilder(
                                  future: areNotificationsActivated(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return Swap(
                                        setActivated: snapshot.data ?? false,
                                        onSwapChange: onSwapChangeCallback,
                                      );
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                tr('notificationStatus'),
                                style: const TextStyle(
                                  color: kTextColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'SF Pro Rounded',
                                ),
                              ),
                            ],
                          ),
                        ),
                        FutureBuilder(
                          future: areNotificationsPermitted(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else {
                              if (!snapshot.data!) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 5, 30, 0),
                                  child: Text(
                                    tr("notificationsNotPermittedMessage"),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 20),
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
                            context.push('/changePassword');
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
      child: Image.memory(
        avatarData.avatar!,
        fit: BoxFit.cover,
      ),
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

/// Set the notifications activated or not in the shared preferences
void setNotificationsActivationState(bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('areNotificationsActivated', value);
}
