import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internationalization/provider/app_locale.dart';
import 'package:provider/provider.dart';

import 'helper/shared_pref.dart';
import 'model/app_language.dart';

class LanguageBasedOnUserSelection extends StatefulWidget {
  const LanguageBasedOnUserSelection({Key? key}) : super(key: key);

  @override
  _LanguageBasedOnUserSelectionState createState() =>
      _LanguageBasedOnUserSelectionState();
}

class _LanguageBasedOnUserSelectionState
    extends State<LanguageBasedOnUserSelection> {
  late String currentDefaultSystemLocale;
  int selectedLangIndex = 0;
  var _appLocale;

  Map<String, String> _languageMap = {
    'en': 'English',
    'de': 'German',
    'fr': 'French'
  };
  late AppLanguage dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = AppLanguage.languages().first;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appLocale = Provider.of<AppLocale>(context);
    getLocale().then((locale) {
      _appLocale.changeLocale(Locale(locale!.languageCode));
      dropdownValue = AppLanguage.languages().firstWhere(
          (element) => element.languageCode == locale!.languageCode);
      _setFlag();
    });
  }

  void _setFlag() {
    currentDefaultSystemLocale = _appLocale.locale.languageCode.split('_')[0];
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
        title: Text('Language based on user selection'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
              child: Column(
            children: [
              DropdownButton<AppLanguage>(
                value: dropdownValue,
                iconSize: 30,
                onChanged: (AppLanguage? language) {
                  dropdownValue = language!;
                  _appLocale.changeLocale(Locale(language!.languageCode));
                  _setFlag();
                  setLocale(language!.languageCode);
                },
                items: AppLanguage.languages()
                    .map<DropdownMenuItem<AppLanguage>>(
                      (e) => DropdownMenuItem<AppLanguage>(
                          value: e, child: Text(e.name)),
                    )
                    .toList(),
              ),
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
                style: TextStyle(fontSize: 30),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
