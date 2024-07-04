import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaki/app_router.dart';
import 'package:yaki/channels.dart';
import 'package:yaki/presentation/state/providers/declaration_provider.dart';

const font = TextStyle(
  fontFamily: 'SF Pro Rounded',
);

class YakiApp extends ConsumerWidget {
  const YakiApp({super.key});

  final Color backgroundColor = const Color(0xFFF2F6F9);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouteProvider = ref.watch(goRouterProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initChannels();
      final declarationRepository = ref.read(declarationRepositoryProvider);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final int? userId = prefs.getInt("userId");
      if (userId == null) {
        debugPrint("Error retrieving userId in app.dart");
        return;
      }
      final declaredDays = await declarationRepository.getDeclaredDays(userId);
      final formatter = DateFormat('yyyy-MM-dd');
      final List<DayRecord> declaredDaysComponents = declaredDays
          .map((e) => formatter.parse(e))
          .map(
            (e) => (year: e.year, month: e.month, day: e.day),
          )
          .toList();
      await scheduleReminderNotifications(
        60,
        declaredDaysComponents,
      );
      debugPrint("The Declared Days were $declaredDays"); //todo remove
    });

    return MaterialApp.router(
      color: backgroundColor,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      title: 'Yaki',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: const MaterialColor(0xFFF2F6F9, {
          50: Color(0xFFE5EAF0),
          100: Color(0xFFBFCEDC),
          200: Color(0xFF95B2C8),
          300: Color(0xFF6A96B4),
          400: Color(0xFF4C84A6),
          500: Color(0xFFF2F6F9),
          600: Color(0xFF2E5C7D),
          700: Color(0xFF244C67),
          800: Color(0xFF1A3D51),
          900: Color(0xFF0F2E3B),
        }),
      ),
      routerConfig: appRouteProvider, // Referencing navigation router
    );
  }
}
