import 'dart:io';

import 'package:path/path.dart';

class Project {
  final Directory arbDirectory;
  final File templateArbFile;

  const Project({
    required this.arbDirectory,
    required this.templateArbFile,
  });

  factory Project.fromJson(dynamic json) {
    final arbDirectory = json['arb-dir'] ?? 'lib/l10n';
    final templateArbFile = json['template-arb-file'] ?? 'app_en.arb';
    return Project(
      arbDirectory: Directory(arbDirectory),
      templateArbFile: File(join(arbDirectory, templateArbFile)),
    );
  }

  Future<void> validate() async {
    if (!await arbDirectory.exists()) {
      throw 'Directory "${arbDirectory.path}" specified in project file does not exist';
    }
    if (!await templateArbFile.exists()) {
      throw 'Directory "${templateArbFile.path}" specified in project file does not exist';
    }
  }
}
