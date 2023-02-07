import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:tint/tint.dart';
import 'package:emojis/emojis.dart';
import 'package:yaml/yaml.dart';

import 'server.dart';
import 'src/project.dart';

Future main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption(
    'project',
    abbr: 'p',
    defaultsTo: '.',
    help:
        'The Lyrebird project file, usually called l10n.yaml. If a directory is passed as this argument, a file called l10n.yaml in the given directory is used',
  );
  final result = parser.parse(args);

  var projectFile = File(result['project']);
  if (!await projectFile.exists()) {
    projectFile = File(join(projectFile.path, 'l10n.yaml'));
  }
  if (!await projectFile.exists()) {
    throw 'Could not find project file "${projectFile.path}".';
  }

  final project = Project.fromJson(loadYaml(
    await projectFile.readAsString(),
    sourceUrl: projectFile.uri,
  ));

  final server = Server(project: project);
  await server.run();
  print(
      '${Emojis.rocket} Open ${server.url.bold().underline()} in your browser to get started.');
}
