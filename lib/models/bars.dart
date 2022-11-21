class Bars {
  final List<Bar> bars;

  Bars({
    required this.bars,
  });

  factory Bars.fromJson(Map<String, dynamic> json) {
    return Bars(
        bars: (json['results'] as List).map((c) => Bar.fromJson(c)).toList());
  }
}

class Bar {
  final double open;
  final double high;
  final double low;
  final double close;

  Bar(
      {required this.open,
      required this.high,
      required this.low,
      required this.close});

  factory Bar.fromJson(dynamic json) {
    return Bar(
      open: json['o'],
      high: json['h'],
      low: json['l'].toDouble(),
      close: json['c'],
    );
  }
}
