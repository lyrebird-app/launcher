import 'dart:io';
import 'dart:isolate';

import 'package:path/path.dart' show basename, extension;
import 'package:alfred/alfred.dart';
import 'package:tint/tint.dart';
import 'package:emojis/emojis.dart';

import 'src/project.dart';

class Server {
  final Alfred _app = Alfred(logLevel: LogType.error);
  String get url => 'http://${_app.server!.address.host}:${_app.server!.port}';

  final Project project;

  Server({required this.project});

  static Future<Directory> _findDefaultBinaryDirectory() async {
    final wwwUri = await Isolate.resolvePackageUri(
      Uri.parse('package:lyrebird/'),
    ).then((uri) => uri?.resolve('../www'));
    if (wwwUri == null) throw 'Web assets not found.';
    return Directory.fromUri(wwwUri);
  }

  // TODO: The current implementation allows probing for existing directories on the server by passing something like `../test/file.arb` as path and seeing if it resolves.
  File _fileFromPath(String path) {
    final file = File.fromUri(project.arbDirectory.absolute.uri.resolve(path));

    // Check if the file is in the given directory.
    if (file.parent.absolute.uri != project.arbDirectory.absolute.uri) {
      throw 'You may not access files outside the given directory.';
    }

    return file;
  }

  Future<void> run() async {
    await project.validate();
    final binaryDirectory = await _findDefaultBinaryDirectory();

    _app.all('*', cors(origin: '*'));

    _app.get('/files', (req, res) async {
      // TODO: Include file metadata.
      return {
        'directory': project.arbDirectory.absolute.uri.toFilePath(),
        'files': await project.arbDirectory
            .list()
            .where((entity) => entity is File)
            .map((file) => basename(file.path))
            .toList(),
      };
    });

    _app.get('/file', (req, res) async {
      final path = req.uri.queryParameters['path'];
      if (path != null) {
        final file = _fileFromPath(path);
        if (!await file.exists()) throw 'File does not exist.';
        return file;
      } else {
        // TODO: Less sketchy validation.
        throw 'No path given.';
      }
    });

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

    print('${Emojis.compass} Listening on $url.');
    print(
        '  ${Emojis.worldMap} Serving static files from \'${binaryDirectory.path.blue()}\'.');
    print(
      '  ${Emojis.package} ARB file directory: \'${project.arbDirectory.absolute.uri.toFilePath().green()}\'.',
    );

    final totalFiles = await project.arbDirectory
        .list()
        .where((entity) => entity is File)
        .toList();
    final arbFiles = totalFiles
        .where((file) => extension(file.path).toLowerCase() == '.arb');
    print(
        '    ${Emojis.pencil} Contains ${'${arbFiles.length} .arb files'.green()} of ${totalFiles.length} files total.');
    if (arbFiles.isEmpty) {
      print(
          '    ${Emojis.redExclamationMark} ${'Warning!'.yellow()} The given ARB directory does not contain any .arb files.');
    }
  }
}
