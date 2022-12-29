import 'dart:io';

import 'package:args/args.dart';

import 'server.dart';

Future main(List<String> args) async {
  final parser = ArgParser();
  final result = parser.parse(args);
  if (result.rest.isEmpty) throw 'Missing file argument';

  final server = Server(
    directory: Directory(result.arguments[0]),
  );
  await server.run();
  print('Open ${server.url} in your browser to get started.');
}
