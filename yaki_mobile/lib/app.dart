import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'appRouter.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: appRouter, // Referencing navigation router
    );
  }
}