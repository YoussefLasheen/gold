import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          child: Consumer(builder: (context, ref, child) {
            final locale = ref.watch(localeProvider);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(AppLocalizations.of(context)!.language),
                  trailing: DropdownButton(
                    value: locale.languageCode,
                    items: AppLocalizations.supportedLocales
                        .map((e) => DropdownMenuItem(
                              value: e.toLanguageTag(),
                              child: Text(e.toLanguageTag()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      ref.read(localeProvider.notifier).change(languageCode: value);
                    },
                  ),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.currency),
                  trailing: DropdownButton(
                    value: locale.countryCode,
                    items: currencies
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      ref.read(localeProvider.notifier).change(countryCode: value);
                    },
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

List<String> currencies = [
  "AUD",
  "EUR",
  "GBP",
  "NZD",
  "AED",
  "AFN",
  "ALL",
  "AMD",
  "ANG",
  "AOA",
  "ARS",
  "ATS",
  "AWG",
  "AZM",
  "AZN",
  "BAM",
  "BBD",
  "BDT",
  "BEF",
  "BGN",
  "BHD",
  "BIF",
  "BMD",
  "BND",
  "BOB",
  "BRL",
  "BSD",
  "BTN",
  "BWP",
  "BYN",
  "BYR",
  "BZD",
  "CAD",
  "CDF",
  "CHF",
  "CLP",
  "CNH",
  "CNY",
  "COP",
  "CRC",
  "CUC",
  "CUP",
  "CVE",
  "CYP",
  "CZK",
  "DEM",
  "DJF",
  "DKK",
  "DOP",
  "DZD",
  "EEK",
  "EGP",
  "ERN",
  "ESP",
  "ETB",
  "FIM",
  "FJD",
  "FKP",
  "FRF",
  "GEL",
  "GGP",
  "GHC",
  "GHS",
  "GIP",
  "GMD",
  "GNF",
  "GRD",
  "GTQ",
  "GYD",
  "HKD",
  "HNL",
  "HRK",
  "HTG",
  "HUF",
  "IDR",
  "IEP",
  "ILS",
  "IMP",
  "INR",
  "IQD",
  "IRR",
  "ISK",
  "ITL",
  "JEP",
  "JMD",
  "JOD",
  "JPY",
  "KES",
  "KGS",
  "KHR",
  "KMF",
  "KPW",
  "KRW",
  "KWD",
  "KYD",
  "KZT",
  "LAK",
  "LBP",
  "LKR",
  "LRD",
  "LSL",
  "LTL",
  "LUF",
  "LVL",
  "LYD",
  "MAD",
  "MDL",
  "MGA",
  "MGF",
  "MKD",
  "MMK",
  "MNT",
  "MOP",
  "MRO",
  "MRU",
  "MTL",
  "MUR",
  "MVR",
  "MWK",
  "MXN",
  "MYR",
  "MZM",
  "MZN",
  "NAD",
  "NGN",
  "NIO",
  "NLG",
  "NOK",
  "NPR",
  "OMR",
  "PAB",
  "PEN",
  "PGK",
  "PHP",
  "PKR",
  "PLN",
  "PTE",
  "PYG",
  "QAR",
  "ROL",
  "RON",
  "RSD",
  "RUB",
  "RWF",
  "SAR",
  "SBD",
  "SCR",
  "SDD",
  "SDG",
  "SEK",
  "SGD",
  "SHP",
  "SIT",
  "SKK",
  "SLL",
  "SOS",
  "SPL",
  "SRD",
  "SRG",
  "STD",
  "STN",
  "SVC",
  "SYP",
  "SZL",
  "THB",
  "TJS",
  "TMM",
  "TMT",
  "TND",
  "TOP",
  "TRL",
  "TRY",
  "TTD",
  "TVD",
  "TWD",
  "TZS",
  "UAH",
  "UGX",
  "UYU",
  "UZS",
  "VAL",
  "VEB",
  "VEF",
  "VES",
  "VND",
  "VUV",
  "WST",
  "XAF",
  "XAG",
  "XAU",
  "XBT",
  "XCD",
  "XDR",
  "XOF",
  "XPD",
  "XPF",
  "XPT",
  "YER",
  "ZAR",
  "ZMK",
  "ZMW",
  "ZWD"
];