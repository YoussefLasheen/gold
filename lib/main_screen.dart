import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/rates.dart';
import 'package:gold/settings_dialog.dart';
import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'components/carat_pricing.dart';
import 'components/chart_card.dart';
import 'components/price_card.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  final String currencyCode;
  const MainScreen({super.key, required this.currencyCode});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<RatesDerivatives> futureAlbum;
  
  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    futureAlbum = fetchRates(widget.currencyCode);
    super.didUpdateWidget(oldWidget);
  }
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchRates(widget.currencyCode);
  }

  @override
  Widget build(BuildContext context, ) {
    //final locale = ref.watch(localeProvider);
    timeago.setLocaleMessages('ar', timeago.ArMessages()); // Add french messages
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.refresh),
        label: Text(AppLocalizations.of(context)!.refresh),
        onPressed: () {
          setState(() {
            futureAlbum = fetchRates(widget.currencyCode!);
          });
        },
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder<RatesDerivatives>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: IconButton(
                          icon: Icon(Icons.settings),
                          onPressed: () {
                            showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: 'Profile',
                                pageBuilder: (BuildContext buildContext,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SettingsDialog(),
                                  );
                                });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ChartCard(),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CaratPricing(data: snapshot.data!, currencyCode: widget.currencyCode,),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: PriceCard(title: AppLocalizations.of(context)!.ouncePrice,price: snapshot.data!.XAUUSD, icon: Icon(FontAwesomeIcons.coins, color: Color(0xFFCCA653),),currencyCode: widget.currencyCode,)),
                              Expanded(child: PriceCard(title: AppLocalizations.of(context)!.dollarPrice,price: snapshot.data!.rates.USDXXX, icon: Icon(FontAwesomeIcons.dollarSign, color: Colors.green),currencyCode: widget.currencyCode,)),
                            ],
                          ),
                          
                          SizedBox(
                            height: 10,
                          ),
                          Text('${AppLocalizations.of(context)!.lastUpdate} ${timeago.format(snapshot.data!.rates.timestamp, locale: Localizations.localeOf(context).toLanguageTag())}',),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
