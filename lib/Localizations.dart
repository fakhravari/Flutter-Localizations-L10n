import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localRepository = LocalizationsApp();

abstract class ILocalizationsApp {
  Future<void> Setlocal(String local);
  Future<void> Loadlocal();
}

class LocalizationsApp implements ILocalizationsApp {
  static ValueNotifier<Locale?> localChangeNotifier =
      ValueNotifier(const Locale('fa'));

  @override
  Future<void> Loadlocal() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String local = sharedPreferences.getString('local') ?? 'fa';

    localChangeNotifier.value = Locale(local);
  }

  @override
  Future<void> Setlocal(String local) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('local', local);

    await Loadlocal();
  }
}

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
