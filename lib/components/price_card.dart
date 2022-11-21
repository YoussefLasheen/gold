import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gold/providers.dart';
import 'package:gold/rates.dart';
import 'package:intl/intl.dart';

class PriceCard extends StatelessWidget {
  final String title;
  final double price;
  final Icon icon;
  final String currencyCode;
  const PriceCard({
    Key? key, required this.price, required this.icon, required this.title, required this.currencyCode
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)  ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 12,
                ),
                Text(NumberFormat.simpleCurrency(name:currencyCode).format(price))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

