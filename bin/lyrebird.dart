import 'dart:io';

import 'package:args/args.dart';

import 'server.dart';

Future main(List<String> args) async {
  final parser = ArgParser();
  final result = parser.parse(args);
  if (result.arguments.isEmpty) throw 'Missing file argument';

  final server = Server(file: File(result.arguments[0]));
  await server.run();
}
