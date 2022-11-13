import 'dart:convert';
import 'dart:io';

import 'package:gold/rates.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<RatesDerivatives> fetchRates() async {
  final prefs = await SharedPreferences.getInstance();

  try {
    final response = await http.get(
        Uri.parse('https://www.freeforexapi.com/api/live?pairs=USDXAU,USDEGP'));
    if (response.statusCode == 200) {
      await prefs.setString('data', response.body);
      Rates rates = Rates.fromJson(jsonDecode(response.body));
      return RatesDerivatives.deriv(rates);
    }
  } on SocketException catch (_) {
    final String? data = prefs.getString('data');

    if (data != null) {
      Rates rates = Rates.fromJson(jsonDecode(data));
      return RatesDerivatives.deriv(rates);
    }
  }
  throw Exception('Failed to load album');
}
