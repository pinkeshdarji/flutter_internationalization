import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBasedOnSystem extends StatefulWidget {
  const LanguageBasedOnSystem({Key? key}) : super(key: key);

  @override
  _LanguageBasedOnSystemState createState() => _LanguageBasedOnSystemState();
}

class _LanguageBasedOnSystemState extends State<LanguageBasedOnSystem> {
  late String currentDefaultSystemLocale;
  int selectedLangIndex = 0;

  @override
  void initState() {
    super.initState();
    currentDefaultSystemLocale = Platform.localeName.split('_')[0];

    _setFlag();
  }

  void _setFlag() {
    setState(() {
      selectedLangIndex = _getLangIndex(currentDefaultSystemLocale);
    });
  }

  int _getLangIndex(String currentDefaultSystemLocale) {
    int _langIndex = 0;
    switch (currentDefaultSystemLocale) {
      case 'en':
        _langIndex = 0;
        break;
      case 'de':
        _langIndex = 1;
        break;
      case 'fr':
        _langIndex = 2;
        break;
    }
    return _langIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language based on system'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
              child: Column(
            children: [
              IndexedStack(
                index: selectedLangIndex,
                children: [
                  Text('🇺🇸',
                      style: TextStyle(
                          fontSize: 250, fontWeight: FontWeight.bold)),
                  Text('🇩🇪',
                      style: TextStyle(
                          fontSize: 250, fontWeight: FontWeight.bold)),
                  Text('🇫🇷',
                      style: TextStyle(
                          fontSize: 250, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                AppLocalizations.of(context)!.hello,
                style: TextStyle(fontSize: 35),
              )
            ],
          )),
        ),
      ),
    );
  }
}
