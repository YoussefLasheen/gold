import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  late SharedPreferences prefs;

  Future _init() async {
    prefs = await SharedPreferences.getInstance();
    var locale = Locale.fromSubtags(
      languageCode: prefs.getString('languageCode') ?? 'en',
      countryCode: prefs.getString('countryCode') ?? 'EGP',
    );
    state = locale;
  }

  LocaleNotifier() : super(Locale('en','EGP')) {
    _init();
  }

  void change({String? languageCode, String? countryCode}) async {
    state = Locale.fromSubtags(
      languageCode: languageCode??state.languageCode,
      countryCode: countryCode??state.countryCode,
    );
    if(languageCode !=null)prefs.setString("languageCode", languageCode);
    if(countryCode !=null)prefs.setString("countryCode", countryCode);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (ref) => LocaleNotifier(),
);