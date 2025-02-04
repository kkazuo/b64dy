import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    );
}

void printUsage(ArgParser argParser) {
  print('''
Usage:
  b64dy <flags>

Flags:''');
  print(argParser.usage);
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag('help') || results.rest.isNotEmpty) {
      printUsage(argParser);
      return;
    }

    _decodeLines();
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}

final _wordsRe = RegExp(r'([^ ]+)|( +)');

void _decodeLines() {
  for (;;) {
    final line = stdin.readLineSync();
    if (line == null) break;

    final words = _wordsRe.allMatches(line);
    for (final word in words) {
      final text = word[0];
      if (text == null) continue;
      if (text.length % 4 != 0) {
        stdout.write(text);
      } else {
        stdout.write(_decodeAsText(text));
      }
    }
    stdout.writeln();
  }
}

String _decodeAsText(String text) {
  final u8 = Utf8Decoder();
  try {
    final decoded = base64Decode(text);
    return u8.convert(decoded);
  } catch (_) {
    return text;
  }
}
