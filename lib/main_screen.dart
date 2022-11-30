import 'package:flutter/material.dart';
import 'package:gold/components/chart_card.dart';
import 'package:gold/components/price_chips/price_chips.dart';

import 'components/settings_dialog.dart';

class MainScreen extends StatelessWidget {
  final String currencyCode;

  const MainScreen({super.key, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: IconButton(
                    icon: const Icon(Icons.settings),
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
                              child: const SettingsDialog(),
                            );
                          });
                    },
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const ChartCard(),
                const SizedBox(
                  height: 75,
                ),
                PriceChips(currencyCode: currencyCode),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
