import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:yaki/app_router.dart';

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

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF2F6F9),
      body: Center(
        child: Text(
          'YAKI',
          style: font,
        ),
      ),
    );
  }
}
