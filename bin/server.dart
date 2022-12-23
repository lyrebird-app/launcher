import 'dart:io';
import 'dart:isolate';
import 'package:alfred/alfred.dart';

class Server {
  final Alfred _app = Alfred();

  Future run() async {
    final wwwUri =
        (await Isolate.resolvePackageUri(Uri.parse('package:lyrebird/')))
            ?.resolve('../www');
    if (wwwUri == null) throw 'Web assets not found.';
    final directory = Directory.fromUri(wwwUri);

    // TODO: Nicer (& colored) logging.
    print('Serving from $directory.');

    // TODO: Return the file whose path was specified via CLI.
    _app.get('/file', (req, res) => File('./demo.arb'));

    // TODO: Implement PUT /file.

    _app.get('/*', (req, res) => directory);

    await _app.listen(32804);
  }
}
