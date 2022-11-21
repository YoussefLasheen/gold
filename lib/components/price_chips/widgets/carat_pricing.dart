import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold/providers.dart';
import 'package:gold/models/rates.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class CaratPricing extends StatelessWidget {
  final RatesDerivatives data;
  final String currencyCode;
  const CaratPricing({super.key, required this.data,required this.currencyCode, });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(50), end: Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.k18, style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(NumberFormat.simpleCurrency(name:currencyCode).format(data.gold18k))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.k24, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,),),
                    Text(NumberFormat.simpleCurrency(name:currencyCode).format(data.gold24k))
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.horizontal(end: Radius.circular(50), start: Radius.circular(10))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.k21, style: TextStyle(fontWeight: FontWeight.bold,)),
                    Text(NumberFormat.simpleCurrency(name:currencyCode).format(data.gold21k))
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
