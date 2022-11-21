import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var locale = Locale(prefs.getString('locale') ?? 'en');
    state = locale;
  }

  LocaleNotifier() : super(Locale('en_EG')) {
    _init();
  }

  void change(Locale locale) async {
    state = locale;
    prefs.setString("locale", locale.toString());
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);