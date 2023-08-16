import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/ui/shared/views/header.dart';
import 'package:yaki/presentation/ui/shared/views/input_app.dart';
import 'package:yaki/presentation/state/providers/team_provider.dart';

/// using ConsumerWidget (statelessWidget) to have access to the WidgetRef object
/// allowing the current widget to have access to any provider.
class Authentication extends ConsumerStatefulWidget {
  const Authentication({super.key});

  @override
  ConsumerState<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  // store the value of the 'rememberMe' checkbox
  bool isChecked = false;
  // store the user default login details
  List<String> loginDetails = ["", ""];

  // function that retrieve from the shared preferences the user default
  // login details and the 'rememberMe' checkbox default value before
  // the widgets are mounted
  void _initiateCheckboxValue() async {
    var rememberMe = await SharedPref.getRememberMe();
    var storedLoginDetails = await SharedPref.getLoginDetails();

    setState(() {
      isChecked = rememberMe;
      loginDetails = storedLoginDetails;
    });

    loginController.text = storedLoginDetails.first;
    passwordController.text = storedLoginDetails.last;
  }

  @override
  void initState() {
    _initiateCheckboxValue();
    super.initState();
  }

  /// on 'Sign in' button press/tap :
  /// * delete the previously saved token in the sharedPreferences
  /// * if the rememberMe checkbox value is true, store the login details
  /// * POST to the API the login information's, by invoking the loginRepositoryProvider.userAuthentication() method,
  /// then retrieve the boolean to know if the logged user is a captain.
  ///
  /// Depending of the newly saved token and if the user is a captain or not :
  /// * route to the captain page
  ///
  /// Or
  /// * route to the declaration page
  /// fetch the latest declaration and retrieve the status,
  ///
  /// if not null
  /// route to the status page directly
  ///
  /// if null
  /// route to the declaration page
  void onPressAuthent({
    required WidgetRef ref,
    required String login,
    required String password,
    required Function goToDeclarationPage,
    required Function goToStatusPage,
    required Function goToHalfdayStatusPage,
    required Function goToCaptain,
  }) async {
    await SharedPref.deleteToken();
    // if the rememberMe checkbox value is true, store the login details
    // in the shared preferences
    if (await SharedPref.getRememberMe()) {
      await SharedPref.setLoginDetails(login, password);
    }
    final bool authenticationResult = await ref
        .read(loginRepositoryProvider)
        .userAuthentication(login, password);
    if (authenticationResult && await SharedPref.isTokenPresent()) {
      final bool isCaptain = ref.read(loginRepositoryProvider).isCaptain();
      if (isCaptain) {
        goToCaptain();
      } else {
        ref.read(teamProvider.notifier).fetchTeams();
        final declarationStatus =
            await ref.read(declarationProvider.notifier).getLatestDeclaration();
        if (declarationStatus.length > 1) {
          goToHalfdayStatusPage();
        } else if (declarationStatus.length == 1 &&
            declarationStatus != emptyDeclarationStatus) {
          goToStatusPage();
        } else {
          goToDeclarationPage();
        }
      }
    } else {
      showSnackBar();
    }
  }

  // Show a snackbar at the bottom of the screen to notice the user that
  // the login information he put are wrong
  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('authenticationFailed')),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onPressSignUp({required Function goToRegistrationPage}) {
    goToRegistrationPage();
  }

  @override
  Widget build(BuildContext context) {
    // Size of the device
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Header(
              pictoPath: 'assets/images/authent.svg',
              headerTitle: tr('headerTitle'),
              headerHint: tr('headerHint'),
            ),
          ),
          Expanded(
            flex: 7,
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height / 15,
                        right: 50,
                        left: 50,
                      ),
                      child: InputApp(
                        defaultValue: loginDetails.first,
                        inputText: tr('inputLogin'),
                        inputHint: tr('hintLogin'),
                        password: false,
                        controller: loginController,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 50, left: 50),
                      child: InputApp(
                        defaultValue: loginDetails.last,
                        inputText: tr('inputPassword'),
                        inputHint: tr('hintPassword'),
                        password: true,
                        controller: passwordController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            activeColor: AppColors.yakiPrimaryColor,
                            onChanged: (bool? value) async {
                              setState(() {
                                isChecked = value ?? false;
                              });
                              await SharedPref.setRememberMe(value ?? false);
                            },
                          ),
                          Text(
                            tr('rememberMe'),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          backgroundColor: AppColors.yakiPrimaryColor,
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: size.height / 25,
                            fontWeight: FontWeight.w600,
                          ),
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            right: 50,
                            left: 50,
                          ),
                        ),
                        onPressed: () => onPressAuthent(
                          ref: ref,
                          login: loginController.text,
                          password: passwordController.text,
                          goToDeclarationPage: () =>
                              context.push('/declaration'),
                          goToStatusPage: () => context.go('/status'),
                          goToCaptain: () => context.go('/captain'),
                          goToHalfdayStatusPage: () =>
                              context.go('/halfdayStatus'),
                        ),
                        child: Text(tr('signIn')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Text(
                        tr('createAccountInvitFormule'),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () => onPressSignUp(
                          goToRegistrationPage: () =>
                              context.push('/registration'),
                        ),
                        borderRadius: BorderRadius.circular(5),
                        highlightColor: const Color.fromARGB(103, 243, 194, 18),
                        splashColor: const Color.fromARGB(125, 46, 46, 46),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            tr('createAccountLink'),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
