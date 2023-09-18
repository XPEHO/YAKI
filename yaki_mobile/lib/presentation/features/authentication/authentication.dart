import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/domain/entities/declaration_status.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki_ui/yaki_ui.dart';

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
  final Color backgroundColor = const Color(0xFFF2F6F9);
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
    required Function goToVacationStatusPage,
    required Function goToCaptain,
    required Function goToUserDefaultRedirection,
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
      final bool isTeammate = ref.read(loginRepositoryProvider).isTeammate();
      if (isCaptain) {
        goToCaptain();
      } else if (isTeammate) {
        final declarationStatus =
            await ref.read(declarationProvider.notifier).getLatestDeclaration();
        if (declarationStatus.length > 1) {
          goToHalfdayStatusPage();
        } else if (declarationStatus.length == 1 &&
            declarationStatus != emptyDeclarationStatus) {
          if (declarationStatus.first == 'vacation') {
            goToVacationStatusPage();
          } else {
            goToStatusPage();
          }
        } else {
          goToDeclarationPage();
        }
      } else {
        goToUserDefaultRedirection();
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

  void onPressedForgotPassword({required Function goToForgotPassword}) {
    goToForgotPassword();
  }

  @override
  Widget build(BuildContext context) {
    // Size of the device
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Text(
                  tr('signInLowercase'),
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height / 15,
                        ),
                        child: InputText(
                          type: InputTextType.email,
                          label: tr('inputLogin'),
                          controller: loginController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InputText(
                          type: InputTextType.password,
                          label: tr('inputPassword'),
                          controller: passwordController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Button(
                          text: tr('signIn'),
                          onPressed: () => onPressAuthent(
                            ref: ref,
                            login: loginController.text,
                            password: passwordController.text,
                            goToDeclarationPage: () =>
                                context.push('/team-selection'),
                            goToStatusPage: () => context.go('/status'),
                            goToCaptain: () => context.go('/captain'),
                            goToHalfdayStatusPage: () =>
                                context.go('/halfdayStatus'),
                            goToVacationStatusPage: () =>
                                context.go('/vacationStatus'),
                            goToUserDefaultRedirection: () =>
                                context.go('/userDefaultRedirection'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Button.secondary(
                          text: tr('forgotPassword'),
                          onPressed: () => onPressedForgotPassword(
                            goToForgotPassword: () =>
                                context.push('/forgotPassword'),
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
                          borderRadius: BorderRadius.circular(16),
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
            ],
          ),
        ),
      ),
    );
  }
}
