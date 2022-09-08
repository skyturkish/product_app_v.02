import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onurun/core/constants/navigation/navigation_constants.dart';
import 'package:onurun/core/init/navigation/navigation_service.dart';

import 'core/init/navigation/navigation_route.dart';

Future<void> main() async {
  await _init();
  runApp(const MyApp());
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      initialRoute: NavigationConstants.LOGIN_VIEW,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}
