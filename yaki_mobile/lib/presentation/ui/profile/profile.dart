import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/domain/entities/logged_user.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/ui/shared/pages_layout.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';
import 'package:yaki/presentation/ui/shared/views/input_with_label_app.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoggedUser? user = ref.watch(loginRepositoryProvider).loggedUser;

    return Scaffold(
      body: PagesLayout(
        header: Header(
          pictoIcon: 'assets/images/exit.svg',
          // if there is no captainId, show the teamMate icon,
          // else show the captain icon
          pictoPath: user?.captainId != null
              ? 'assets/images/captain.svg'
              : 'assets/images/avatar1.svg',
          headerTitle: tr('headerTitleProfile'),
          headerHint: tr('headerHintProfile'),
          onPressed: () {
            context.pop();
          },
        ),
        bodyContent: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
                child: InputWithLabelApp(
                  label: tr('inputLabelFirstName'),
                  initialValue: user?.firstName ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: InputWithLabelApp(
                  label: tr('inputLabelLastName'),
                  initialValue: user?.lastName ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: InputWithLabelApp(
                  label: 'Email',
                  initialValue: user?.email ?? '',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 5,
                      backgroundColor: const Color.fromARGB(255, 191, 192, 193),
                      foregroundColor: const Color.fromARGB(255, 253, 253, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      context.go('/changePassword');
                    },
                    child: Text(
                      tr('changePassword'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 40.0),
                child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.red,
                      foregroundColor: const Color.fromARGB(255, 253, 253, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                        right: 50,
                        left: 50,
                      ),
                    ),
                    onPressed: () {
                      context.go('/');
                    },
                    child: Text(
                      tr('logOutButton'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
