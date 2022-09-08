import 'package:flutter/material.dart';

class NavigationHomeView extends StatefulWidget {
  const NavigationHomeView({Key? key}) : super(key: key);

  @override
  State<NavigationHomeView> createState() => _NavigationHomeViewState();
}

class _NavigationHomeViewState extends State<NavigationHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('navigation bar'),
      ),
    );
  }
}
