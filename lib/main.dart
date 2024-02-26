import 'package:flutter/material.dart';

import 'config/config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(LaMovApp());
}

class LaMovApp extends StatelessWidget {
  LaMovApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'LaMov App',
      theme: flexSchemeDark,
      routerConfig: _appRouter.config(),
    );
  }
}
