import 'package:flutter/material.dart';
import 'package:gold/rates.dart';

class CaratPricing extends StatelessWidget {
  final RatesDerivatives data;
  const CaratPricing({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCCA653),
                  borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(50))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("18 قيراط", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('${data.gold18k.toStringAsFixed(2)} جنية')
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Color(0xFFFFD700),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("24 قيراط", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                    Text('${data.gold24k.toStringAsFixed(2)} جنية')
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDDB637),
                  borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(50))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("21 قيراط", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('${data.gold21k.toStringAsFixed(2)} جنية', )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
