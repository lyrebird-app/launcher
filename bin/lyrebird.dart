import 'dart:io';

import 'package:args/args.dart';
import 'package:tint/tint.dart';
import 'package:emojis/emojis.dart';

import 'server.dart';

Future main(List<String> args) async {
  final parser = ArgParser();
  final result = parser.parse(args);
  if (result.rest.isEmpty) throw 'Missing file argument';

  final server = Server(
    directory: Directory(result.arguments[0]),
  );
  await server.run();
  print(
      '${Emojis.rocket} Open ${server.url.bold().underline()} in your browser to get started.');
}
