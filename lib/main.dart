import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold/constants.dart';
import 'package:gold/main_screen.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'providers.dart';

void main() {
  runApp(const ProviderScope(child:  MyApp()));
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

        return Consumer(
          builder: (context, ref, _) {
            final locale = ref.watch(localeProvider);
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
              locale: locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: MainScreen(currencyCode: locale.countryCode!,),
            );
          }
        );
      },
    );
  }
}
