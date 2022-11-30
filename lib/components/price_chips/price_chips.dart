import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/models/rates.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'widgets/carat_pricing.dart';
import 'widgets/price_card.dart';

class PriceChips extends StatefulWidget {
  final String currencyCode;

  const PriceChips({super.key, required this.currencyCode});

  @override
  State<PriceChips> createState() => _PriceChipsState();
}

class _PriceChipsState extends State<PriceChips> {
  late Future<RatesDerivatives> futureAlbum;

  @override
  void didUpdateWidget(covariant PriceChips oldWidget) {
    futureAlbum = fetchRates(widget.currencyCode);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchRates(widget.currencyCode);
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar', timeago.ArMessages());
    timeago.setLocaleMessages(
        'zh', timeago.ZhMessages()); // Add french messages
    return Column(
      children: [
        FutureBuilder<RatesDerivatives>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CaratPricing(
                    data: snapshot.data!,
                    currencyCode: widget.currencyCode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: PriceCard(
                        title: AppLocalizations.of(context)!.ouncePrice,
                        price:
                            snapshot.data!.XAUUSD * snapshot.data!.rates.USDXXX,
                        icon: const Icon(
                          FontAwesomeIcons.coins,
                          color: Color(0xFFCCA653),
                        ),
                        currencyCode: widget.currencyCode,
                      )),
                      Expanded(
                          child: PriceCard(
                        title: AppLocalizations.of(context)!.dollarPrice,
                        price: snapshot.data!.rates.USDXXX,
                        icon: const Icon(FontAwesomeIcons.dollarSign,
                            color: Colors.green),
                        currencyCode: widget.currencyCode,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${AppLocalizations.of(context)!.lastUpdate} ${timeago.format(snapshot.data!.rates.timestamp, locale: Localizations.localeOf(context).toLanguageTag())}',
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SizedBox(
                      width: 100,
                      child: FloatingActionButton.extended(
                        icon: const Icon(Icons.refresh),
                        label: Text(AppLocalizations.of(context)!.refresh),
                        onPressed: () {
                          setState(() {
                            futureAlbum = fetchRates(widget.currencyCode);
                          });
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
