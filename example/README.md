# Lyrebird Example

This is a Flutter example application showcasing how to use the [Lyrebird](../) localization editor in a real world app.
It follows the setup described in [the Flutter documentation](https://docs.flutter.dev/development/accessibility-and-localization/internationalization),
which generates source code for the [intl](https://pub.dev/packages/intl) package from Application Resource Bundle (`.arb`) files.

Navigate to the example project in your terminal, then run
```bash
flutter pub run lyrebird lib/l10n
```
to start editing the `.arb` localization files in that directory.

At any point, you can run
```bash
flutter gen-l10n
```
to regenerate the localization source code.