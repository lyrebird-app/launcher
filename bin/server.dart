import 'dart:io';
import 'dart:isolate';
import 'package:alfred/alfred.dart';

class Server {
  final Alfred _app = Alfred();
  String get url => 'http://${_app.server!.address.host}:${_app.server!.port}';

  final Directory directory;

  Server({
    required this.directory,
  }) {
    if (!directory.existsSync()) throw 'The given directory does not exist.';
  }

  static Future<Directory> _findDefaultBinaryDirectory() async {
    final wwwUri = await Isolate.resolvePackageUri(
      Uri.parse('package:lyrebird/'),
    ).then((uri) => uri?.resolve('../www'));
    if (wwwUri == null) throw 'Web assets not found.';
    return Directory.fromUri(wwwUri);
  }

  File _fileFromPath(String path) {
    final file = File(directory.absolute.uri
        .resolve(path)
        .normalizePath()
        .toFilePath(windows: false)
        .normalizePath);

    // Check if the file is in the given directory.
    if (file.parent.absolute.path !=
        directory.absolute.uri
            .normalizePath()
            .toFilePath(windows: false)
            .normalizePath) {
      throw 'You may not write to files outside the given directory.';
    }

    return file;
  }

  Future<void> run() async {
    final binaryDirectory = await _findDefaultBinaryDirectory();

    // TODO: Nicer (& colored) logging.
    print('Serving from ${binaryDirectory}.');

    _app.all('*', cors(origin: '*'));

    _app.get('/file', (req, res) async {
      final path = req.uri.queryParameters['path'];
      if (path != null) {
        final file = _fileFromPath(path);
        if (!await file.exists()) throw 'File to does not exist.';
        return file;
      } else {
        // TODO: Less sketchy validation.
        throw 'No path given.';
      }
    });

    // TODO: The current implementation allows probing for existing directories on the server by passing something like `../test/file.arb` as path and seeing if it resolves.
    // TODO: Only allow arb files?
    _app.put('/file', (req, res) async {
      final path = req.uri.queryParameters['path'];
      if (path != null) {
        final file = _fileFromPath(path);
        if (!await file.exists()) throw 'File to update does not exist.';
        await file.writeAsString((await req.body).toString(), flush: true);
      } else {
        // TODO: Less sketchy validation.
        throw 'No path given.';
      }
    });

    _app.get('/*', (req, res) async {
      return binaryDirectory;
    });

    await _app.listen(32804, 'localhost');
  }
}
