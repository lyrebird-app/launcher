<p align="center">
    <img src="./logo.svg" width="400" alt="Lyrebird">
</p>

A visual editor for `.ARB` localization files, enabling rapid development. It is specifically designed to be used for Dart and Flutter projects using the [intl](https://pub.dev/packages/intl) package.

The editor runs locally on your machine, meaning you can use familiar versioning tools like Git and do not have to upload or download localizaton files.

**Warning:** This project is very early in development, use with extreme caution! Make sure you have all important changes comitted before trying it out.

**Currently only runs on Linux.** 

## Contents

* [Features](#features)
  * [Supprted](#supported)
  * [Planned](#planned)

## Features

### Supported

* Add and remove localization keys
* Edit a localization keys' metadata
* Add, edit, and remove placeholder variables
* Edit the ICU value of a localization using a visual editor
  * Text blocks
  * Arguments
  * Select with branches
  * Plural with branches
    * Plural arguments
  * Newlines

### Planned

* Windows and MacOS support
* Proper error handling
* A "try it out" section to test your localizations
* Editing multiple files at once, with one primary language
* Creating new files
* Support for XML tags
* A subscription service for automated machine translations (e.g. using DeepL)

## Installation

To install the Lyrebird launcher, run the command
```bash
pub global activate lyrebird
```
Or, if you are using the Flutter CLI, run
```bash
flutter pub global activate lyrebird
```