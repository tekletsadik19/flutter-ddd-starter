import 'package:flutter/widgets.dart';
import 'package:ddd_flutter_app/l10n/arb/app_localizations.dart';

export 'package:ddd_flutter_app/l10n/arb/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
