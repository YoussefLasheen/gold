import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/rates.dart';
import 'package:intl/intl.dart';

import 'package:timeago/timeago.dart' as timeago;

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
      backgroundColor:const  Color(0xFF142e1a),
      body: SingleChildScrollView(
        child: FutureBuilder<RatesDerivatives>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Placeholder(
                      fallbackHeight: 300,
                      color: Colors.white,
                    ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                              backgroundColor: Colors.green
                            ),
                            onPressed: () {
                              setState(() {
                                futureAlbum = fetchRates();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text('تحديث'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('تم التحديث ${timeago.format(snapshot.data!.rates.timestamp, locale: 'ar')}', style: TextStyle(color: Colors.white),),
                        ),
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
    );
  }
}

class PriceCard extends StatelessWidget {
  final String title;
  final double price;
  final Icon icon;
  const PriceCard({
    Key? key, required this.price, required this.icon, required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
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
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)  ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 12,
                ),
                Text(
                  '${price.toStringAsFixed(2)} جنيه',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
