import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yaki/data/sources/local/shared_preference.dart';
import 'package:yaki/presentation/features/shared/feedback_user.dart';
import 'package:yaki/presentation/state/providers/avatar_provider.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';
import 'package:yaki/presentation/state/providers/login_provider.dart';
import 'package:yaki/presentation/styles/color.dart';
import 'package:yaki/presentation/styles/text_style.dart';
import 'package:yaki_ui/yaki_ui.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url =
    Uri.parse('https://github.com/XPEHO/YAKI/blob/main/PRIVACY_POLICY.md');

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
  List<String> loginDetails = ["", ""];

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
    final String lowercaseLogin = login.toLowerCase().trim();
    final String trimPassword = password..trim();
    await SharedPref.deleteToken();
    await SharedPref.setLoginDetails(lowercaseLogin, trimPassword);

    final bool authenticationResult = await ref
        .read(loginRepositoryProvider)
        .userAuthentication(lowercaseLogin, trimPassword);
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
      setLoading(false);
    }
  }

  showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(tr('authenticationFailed')),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void onPressSignUp({
    required Function goToRegistrationPage,
    required Function getAvatar,
  }) {
    getAvatar();
    goToRegistrationPage();
  }

  void onPressedForgotPassword({required Function goToForgotPassword}) {
    goToForgotPassword();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04), // 4% of screen width
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height / 20),
                  Image.asset(
                    'assets/images/yaki_basti_icon.png',
                    height: size.width * 0.2, // 20% of screen width
                    width: size.width * 0.2, // 20% of screen width
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
                          readOnly: false,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ), // 2% of screen height
                        InputText(
                          type: InputTextType.password,
                          label: tr('inputPassword'),
                          controller: passwordController,
                          readOnly: false,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ), // 1% of screen height
                        _isLoading
                            ? Padding(
                                padding: EdgeInsets.all(
                                  size.width * 0.02,
                                ), // 2% of screen width
                                child: const CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  strokeWidth: 5,
                                  semanticsLabel: 'Loading',
                                ),
                              )
                            : Button(
                                buttonHeight:
                                    size.height * 0.09, // 9% of screen height
                                text: tr('signIn').toUpperCase(),
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
                        SizedBox(
                          height: size.height * 0.005,
                        ), // 0.5% of screen height
                        Button.secondary(
                          buttonHeight:
                              size.height * 0.08, // 8% of screen height
                          text: tr('forgotPassword').toUpperCase(),
                          onPressed: () => onPressedForgotPassword(
                            goToForgotPassword: () =>
                                context.go('/forgotPassword'),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ), // 1% of screen height
                        InkWell(
                          onTap: () => onPressSignUp(
                            getAvatar: () =>
                                ref.read(avatarProvider.notifier).getAvatar(),
                            goToRegistrationPage: () =>
                                context.go('/registration'),
                          ),
                          borderRadius: BorderRadius.circular(16),
                          splashColor: const Color.fromARGB(125, 46, 46, 46),
                          child: Padding(
                            padding: EdgeInsets.all(
                              size.width * 0.02,
                            ), // 2% of screen width
                            child: Text(
                              tr('createAccountLink'),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ), // 1% of screen height
                        const FeedbackUser(),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.02), // 2% of screen height
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
                      SizedBox(width: size.width * 0.02), // 2% of screen width
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
