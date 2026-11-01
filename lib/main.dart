import 'package:flutter/material.dart';
import 'package:sandwich_shop/screens/menu_screen.dart';
import 'package:sandwich_shop/constants.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appTitle',
      home: const MenuScreen(),
      debugShowCheckedModeBanner: false, // removes the red ribbon
       theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: shopBrand,
          primary: shopBrand,
        ),
        scaffoldBackgroundColor: shopBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: shopBrand,
          foregroundColor: shopWhite,
          elevation: 0,
        ),
      ),
    );
  }
}
