import 'dart:io';
import 'dart:isolate';
import 'package:alfred/alfred.dart';

class Server {
  final Alfred _app = Alfred();
  String get url => 'http://${_app.server!.address.host}:${_app.server!.port}';

  final File file;

  Server({
    required this.file,
  });

  static Future<Directory> _findDefaultBinaryDirectory() async {
    final wwwUri = await Isolate.resolvePackageUri(
      Uri.parse('package:lyrebird/'),
    ).then((uri) => uri?.resolve('../www'));
    if (wwwUri == null) throw 'Web assets not found.';
    return Directory.fromUri(wwwUri);
  }

  Future<void> run() async {
    final binaryDirectory = await _findDefaultBinaryDirectory();

    // TODO: Nicer (& colored) logging.
    print('Serving from ${binaryDirectory}.');

    _app.all('*', cors(origin: '*'));

    _app.get('/file', (req, res) => file);
    _app.put('/file', (req, res) async {
      await file.writeAsString((await req.body).toString(), flush: true);
    });

    _app.get('/*', (req, res) async {
      return binaryDirectory;
    });

    await _app.listen(32804, 'localhost');
  }
}
