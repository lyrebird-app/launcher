<br>
<p align="center">
  <img src="https://user-images.githubusercontent.com/8947616/211387982-b8fc2897-e0a7-4a27-b850-f46dea620c8c.svg" width="512" alt="Lyrebird - Localization tool for Dart and Flutter">
</p>
<p align="center">
  <a href="https://lyrebird.dev">Website</a> · <a href="https://lyrebird.dev/why-lyrebird">Documentation</a> · <a href="https://github.com/lyrebird-app">GitHub</a> · <a href="https://pub.dev/packages/lyrebird">pub.dev</a>
</p>
<br>

A visual editor for Application Resource Bundle (`.arb`) localization files, enabling rapid development. It is specifically designed to be used for Dart and Flutter projects using the [intl](https://pub.dev/packages/intl) package.

The editor runs locally on your machine, meaning you can use familiar versioning tools like Git and do not have to upload or download localization files.

**Warning:** This project is very early in development, use with extreme caution! Make sure you have all important changes committed before trying it out.

<br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/8947616/209474797-8d511b16-2144-4f43-868a-6a4a078abc0c.png" alt="Lyrebird editor screenshot">
</p>

<br>

## Contents

* [Features](#features)
  * [Supprted](#supported)
  * [Planned](#planned)
* [Installation](#installation)
* [Configuration](#configuration)
* [Usage](#usage)

## Features

### Supported

* Add and remove localization keys
* Edit a localization keys' metadata
* Add, edit, and remove placeholder variables
* Edit the ICU value of a localization entry using a visual editor
  * Text blocks
  * Arguments
  * Select with branches
  * Plural with branches
    * Plural arguments

### Planned

* Proper error handling
* A "try it out" section to test your localizations
* Creating new files
* Dark theme
* Support for XML tags
* Collapsable nodes
* Textual ICU editor
* A subscription service for automated machine translations (e.g. using DeepL)

## Installation

To install the Lyrebird launcher, run the command:
```bash
dart pub global activate lyrebird
```
Or, if you are using the Flutter CLI, run:
```bash
flutter pub global activate lyrebird
```

Optionally, you can add Lyrebird to your PATH variable. Consult [the Dart documentation](https://dart.dev/tools/pub/cmd/pub-global#running-a-script-from-your-path) for more information.

## Configuration

Lyrebird uses the [`l10n.yaml` configuration file](https://docs.flutter.dev/development/accessibility-and-localization/internationalization#configuring-the-l10nyaml-file)
defined by the Flutter team and obeyed by the `flutter gen-l10n` command
as its project file. More specifically, the `arb-dir` field will be opened by Lyrebird for editing.
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

If you are working on a pure-Dart project, don't worry! You can also create an `l10n.yaml` file without using Flutter.

## Usage

Navigate to the directory containing the `l10n.yaml` file in your terminal.
If you added Lyrebird to your PATH in the previous step, simply run
```bash
lyrebird
```
Otherwise, with the Dart CLI, run:
```bash
dart pub global run lyrebird
```
Or, using the Flutter CLI, run:
```bash
flutter pub global run lyrebird
```

Open the URL printed to the standard output in your browser. Use `Ctrl+S` (or `Cmd+S` on a Mac) to save your changes.

For more options, see
```bash
lyrebird --help
```
