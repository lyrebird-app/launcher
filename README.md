<br>
<p align="center">
    <img src="https://user-images.githubusercontent.com/8947616/209372156-a47d6ad5-7f2f-43b9-8b74-114392d8c091.svg" width="400" alt="Lyrebird">
</p>
<br>
<br>

A visual editor for Application Resource Bundle (`.arb`) localization files, enabling rapid development. It is specifically designed to be used for Dart and Flutter projects using the [intl](https://pub.dev/packages/intl) package.

The editor runs locally on your machine, meaning you can use familiar versioning tools like Git and do not have to upload or download localization files.

**Warning:** This project is very early in development, use with extreme caution! Make sure you have all important changes committed before trying it out.

<br>

<img src="https://user-images.githubusercontent.com/8947616/209474797-8d511b16-2144-4f43-868a-6a4a078abc0c.png" alt="Screenshot">

<br>

## Contents

* [Features](#features)
  * [Supprted](#supported)
  * [Planned](#planned)
* [Installation](#installation)
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
* Editing multiple files at once, with one primary language
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

## Usage

Lyrebird can currently only edit a single `.arb` file at a time.

If you added Lyrebird to your PATH in the previous step, simply run
```bash
lyrebird ./yourFile.arb
```
Otherwise, with the Dart CLI, run:
```bash
dart pub global run lyrebird ./yourFile.arb
```
Or, using the Flutter CLI, run:
```bash
flutter pub global run lyrebird ./yourFile.arb
```

Open the URL printed to the standard output in your browser. Use `Ctrl+S` (or `Cmd+S` on a Mac) to save your changes.
