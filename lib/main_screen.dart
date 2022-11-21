import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/rates.dart';
import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'components/carat_pricing.dart';
import 'components/chart_card.dart';
import 'components/price_card.dart';
class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<RatesDerivatives> futureAlbum;

  @override
  void initState() {
    super.initState();
    
    futureAlbum = fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ar', timeago.ArMessages()); // Add french messages
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.refresh),
        label: Text('تحديث'),
        onPressed: () {
          setState(() {
            futureAlbum = fetchRates();
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
                          CaratPricing(data: snapshot.data!),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Expanded(child: PriceCard(title: "سعر الأونصه",price: snapshot.data!.XAUUSD, icon: Icon(FontAwesomeIcons.coins, color: Color(0xFFCCA653),),)),
                              Expanded(child: PriceCard(title: "سعر الدولار",price: snapshot.data!.rates.USDEGP, icon: Icon(FontAwesomeIcons.dollarSign, color: Colors.green),)),
                            ],
                          ),
                          
                          SizedBox(
                            height: 10,
                          ),
                          Text('تم التحديث ${timeago.format(snapshot.data!.rates.timestamp, locale: 'ar')}',),
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
