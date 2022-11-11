import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:gold/api.dart';
import 'package:gold/rates.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      backgroundColor:const  Color(0xFF142e1a),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureAlbum = fetchRates();
          });
        },
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
                        PriceCard(price: snapshot.data!.gold24k, icon: Icon(FontAwesomeIcons.coins, color: Color(0xFFFFD700),),),
                        PriceCard(price: snapshot.data!.gold21k, icon: Icon(FontAwesomeIcons.coins, color: Color(0xFFDDB637),),),
                        PriceCard(price: snapshot.data!.gold18k, icon: Icon(FontAwesomeIcons.coins, color: Color(0xFFCCA653),),),
                        PriceCard(price: snapshot.data!.rates.USDEGP, icon: Icon(FontAwesomeIcons.dollarSign, color: Colors.green),),
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
                          child: Text('تم التحديث في ${DateFormat('yyyy-MM-dd – kk:mm').format(snapshot.data!.rates.timestamp)}', style: TextStyle(color: Colors.white),),
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
  final double price;
  final Icon icon;
  const PriceCard({
    Key? key, required this.price, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(width:12,),
            Text(
            '${price.toStringAsFixed(2)} جنيه',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          ],
        ),
      ),
    );
  }
}
