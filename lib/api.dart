import 'dart:convert';

import 'package:gold/rates.dart';
import 'package:http/http.dart' as http;

Future<RatesDerivatives> fetchRates() async {
  final response = await http
      .get(Uri.parse('https://www.freeforexapi.com/api/live?pairs=USDXAU,USDEGP'));

  if (response.statusCode == 200) {
    Rates rates = Rates.fromJson(jsonDecode(response.body));
    return RatesDerivatives.deriv(rates);
  } else {
    throw Exception('Failed to load album');
  }
}