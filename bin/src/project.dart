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
    return Project(
      arbDirectory: Directory(json['arb-dir']),
      templateArbFile: File(join(json['arb-dir'], json['template-arb-file'])),
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
