class Rates {
  final DateTime timestamp;
  final double USDXAU;
  final double USDEGP;

  Rates({
    required this.USDXAU,
    required this.USDEGP,
    required this.timestamp,
  });

  factory Rates.fromJson(Map<String, dynamic> json) {
    return Rates(
      USDXAU: json['rates']['USDXAU']['rate'],
      USDEGP: json['rates']['USDEGP']['rate'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['rates']['USDXAU']['timestamp']*1000),
    );
  }
}

class RatesDerivatives {
  final Rates rates;
  final double gold18k;
  final double gold21k;
  final double gold24k;
  final double XAUUSD;

  RatesDerivatives(
      {required this.rates,
      required this.gold18k,
      required this.gold21k,
      required this.gold24k,
      required this.XAUUSD});

  factory RatesDerivatives.deriv(Rates rates) {
    double gold24 = (((1 / rates.USDXAU) / 31.1034768) * rates.USDEGP)* 1.05;
    return RatesDerivatives(
        gold18k: gold24 * 0.75,
        gold21k: gold24 * 0.875,
        gold24k: gold24,
        XAUUSD: 1 / rates.USDXAU,
        rates: rates);
  }
}
