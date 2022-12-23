import 'server.dart';

Future main() async {
  final server = Server();
  await server.run();

  // TODO: Open browser.
}
