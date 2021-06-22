import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_internationalization/provider/app_locale.dart';
import 'package:provider/provider.dart';

import 'language_based_on_user_selection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppLocale(),
      child: Consumer<AppLocale>(builder: (context, locale, child) {
        return MaterialApp(
          title: 'Flutter translation',
          localizationsDelegates:
              AppLocalizations.localizationsDelegates, // important
          supportedLocales: AppLocalizations.supportedLocales, //
          locale: locale.locale,
          theme: ThemeData(
            primarySwatch: Colors.teal,
            brightness: Brightness.dark,
          ),
          home: LanguageBasedOnUserSelection(),
        );
      }),
    );
  }
}
