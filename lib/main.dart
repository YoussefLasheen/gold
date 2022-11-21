import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:gold/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme darkColorScheme;
        ColorScheme lightColorScheme;

        darkColorScheme = ColorScheme.fromSeed(
          seedColor: Color(0xFF1C6758),
          brightness: Brightness.dark,
        );

        lightColorScheme = ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        );

        return MaterialApp(
          themeMode: ThemeMode.dark,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
          ),
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: MainScreen(),
          ),
        );
      },
    );
  }
}
