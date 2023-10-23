import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url =
    Uri.parse('https://github.com/XPEHO/YAKI/blob/main/PRIVACY_POLICY.md');

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
  bool _isLoading = false;
  // store the user default login details
  List<String> loginDetails = ["", ""];

  // function that retrieve from the shared preferences the user default
  // login details and the 'rememberMe' checkbox default value before
  // the widgets are mounted
  void _initiateCheckboxValue() async {
    var storedLoginDetails = await SharedPref.getLoginDetails();

    setState(() {
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
  void onPressAuthent({
    required WidgetRef ref,
    required String login,
    required String password,
    required Function goToTeamsDeclarationSummary,
    required Function goToTeamSelectionPage,
    required Function goToUserDefaultRedirection,
    required Function(bool) setLoading,
  }) async {
    setLoading(true); // show the loader
    final String lowercaseLogin = login.toLowerCase();
    await SharedPref.deleteToken();
    await SharedPref.setLoginDetails(lowercaseLogin, password);

    final bool authenticationResult = await ref
        .read(loginRepositoryProvider)
        .userAuthentication(lowercaseLogin, password);
    if (authenticationResult && await SharedPref.isTokenPresent()) {
      final bool isCaptain = ref.read(loginRepositoryProvider).isCaptain();
      final bool isTeammate = ref.read(loginRepositoryProvider).isTeammate();
      if (isTeammate || isCaptain) {
        final bool isDeclared =
            await ref.read(declarationProvider.notifier).getLatestDeclaration();

        if (isDeclared) {
          goToTeamsDeclarationSummary();
        } else {
          goToTeamSelectionPage();
        }
      } else {
        goToUserDefaultRedirection();
      }
    } else {
      showSnackBar();
    }
    setLoading(false); // hide the loader
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
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height / 10),
                  Image.asset(
                    'assets/images/yaki_basti_icon.png',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: size.height / 20),
                  Text(
                    tr('signInLowercase'),
                    style: textStylePageTitle(),
                  ),
                  SizedBox(height: size.height / 20),
                  Form(
                    child: Column(
                      children: <Widget>[
                        InputText(
                          type: InputTextType.email,
                          label: tr('inputLogin'),
                          controller: loginController,
                        ),
                        const SizedBox(height: 20),
                        InputText(
                          type: InputTextType.password,
                          label: tr('inputPassword'),
                          controller: passwordController,
                        ),
                        const SizedBox(height: 10),
                        _isLoading
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 5,
                                  semanticsLabel: 'Loading',
                                ),
                              ) // show the loader
                            : Button(
                                buttonHeight: 72,
                                text: tr('signIn'),
                                onPressed: () => onPressAuthent(
                                  ref: ref,
                                  login: loginController.text,
                                  password: passwordController.text,
                                  goToTeamsDeclarationSummary: () =>
                                      context.go('/teams-declaration-summary'),
                                  goToTeamSelectionPage: () =>
                                      context.go('/team-selection'),
                                  goToUserDefaultRedirection: () =>
                                      context.go('/userDefaultRedirection'),
                                  setLoading: (bool isLoading) => setState(() {
                                    _isLoading = isLoading;
                                  }),
                                ),
                              ),
                        const SizedBox(height: 5),
                        Button.secondary(
                          buttonHeight: 64,
                          text: tr('forgotPassword'),
                          onPressed: () => onPressedForgotPassword(
                            goToForgotPassword: () =>
                                context.push('/forgotPassword'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('poweredByXPEHO'),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: _launchUrl,
                        child: Text(
                          tr('privacyPolicy'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
