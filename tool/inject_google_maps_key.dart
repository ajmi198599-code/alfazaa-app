import 'dart:io';

void main() {
  final apiKey = Platform.environment['GOOGLE_MAPS_API_KEY']?.trim() ?? '';
  final indexFile = File('web/index.html');

  if (!indexFile.existsSync()) {
    stderr.writeln('web/index.html not found.');
    exitCode = 1;
    return;
  }

  final html = indexFile.readAsStringSync();
  final updated = html.replaceAll(
    'GOOGLE_MAPS_API_KEY_HERE',
    apiKey.isEmpty ? 'GOOGLE_MAPS_API_KEY_HERE' : apiKey,
  );

  if (updated != html) {
    indexFile.writeAsStringSync(updated);
  }

  if (apiKey.isEmpty) {
    stdout.writeln(
        'GOOGLE_MAPS_API_KEY is empty. ALFAZAA will use the premium simulated map fallback.');
  } else {
    stdout.writeln('Google Maps API key injected into web/index.html.');
  }
}
