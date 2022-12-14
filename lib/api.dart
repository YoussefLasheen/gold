import 'dart:convert';
import 'dart:io';

import 'package:gold/models/bars.dart';
import 'package:gold/models/rates.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

Future<RatesDerivatives> fetchRates(String currencyCode) async {
  final prefs = await SharedPreferences.getInstance();

  try {
    final response = await http.get(Uri.parse(
        'https://www.freeforexapi.com/api/live?pairs=USDXAU,USD$currencyCode'));
    if (response.statusCode == 200) {
      await prefs.setString('data1', response.body);
      Rates rates = Rates.fromJson(jsonDecode(response.body), currencyCode);
      return RatesDerivatives.deriv(rates, multipliers[currencyCode] ?? 0);
    }
  } on SocketException catch (_) {
    final String? data = prefs.getString('data1');

    if (data != null) {
      Rates rates = Rates.fromJson(jsonDecode(data), currencyCode);
      return RatesDerivatives.deriv(rates, multipliers[currencyCode] ?? 0);
    }
  }
  throw Exception('Failed to load album');
}

Future<Bars> fetchBars() async {
  DateFormat format = DateFormat('yyyy-MM-dd');
  String today = format.format(DateTime.now());
  String fromDate =
      format.format(DateTime.now().subtract(const Duration(days: 30)));
  final prefs = await SharedPreferences.getInstance();

  String apiKey = const String.fromEnvironment('POLY_KEY');

  try {
    final response = await http.get(Uri.parse(
        'https://api.polygon.io/v2/aggs/ticker/C:XAUUSD/range/1/day/$fromDate/$today?adjusted=true&sort=asc&limit=120&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      await prefs.setString('data2', response.body);
      Bars rates = Bars.fromJson(jsonDecode(response.body));
      return rates;
    }
  } on SocketException catch (_) {
    final String? data = prefs.getString('data2');

    if (data != null) {
      Bars rates = Bars.fromJson(jsonDecode(data));
      return rates;
    }
  }
  throw Exception('Failed to load album');
}

Map multipliers = {
  'EGP': 1.215,
};
