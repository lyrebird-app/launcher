import 'dart:io';
import 'dart:isolate';
import 'package:alfred/alfred.dart';

class Server {
  final Alfred _app = Alfred();
  final File file;

  Server({required this.file});

  Future<void> run() async {
    final wwwUri = await Isolate.resolvePackageUri(
      Uri.parse('package:lyrebird/'),
    ).then((uri) => uri?.resolve('../www'));
    if (wwwUri == null) throw 'Web assets not found.';

    final directory = Directory.fromUri(wwwUri);

    // TODO: Nicer (& colored) logging.
    print('Serving from $directory.');

    _app.get('/file', (req, res) => file);
    _app.put('/file', (req, res) async {
      await file.writeAsString((await req.body).toString(), flush: true);
    });

    _app.get('/*', (req, res) => directory);

    await _app.listen(32804, '127.0.0.1');
  }
}
