import 'package:flutter/material.dart';
import 'package:gold/components/chart_card.dart';
import 'package:gold/components/price_chips/price_chips.dart';

import 'components/settings_dialog.dart';

class MainScreen extends StatelessWidget {
  final String currencyCode;

  const MainScreen({super.key, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
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
                const Spacer(),
                const Expanded(flex: 3, child: ChartCard()),
                const Spacer(),
                Expanded(
                    flex: 3, child: PriceChips(currencyCode: currencyCode)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
