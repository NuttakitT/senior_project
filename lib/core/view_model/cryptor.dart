import 'dart:convert';
import 'dart:math';

class Cryptor {
  static int defaultSeed = 100 + Random().nextInt(899);

  static List<String> encrypt(String text, {int? customSeed}) {
    List<int> code = const Utf8Encoder().convert(text);
    int key = defaultSeed;
    if (customSeed != null) {
      key = customSeed;
    }
    String encrypt = "";
    for (int i = code.length-1; i > -1; i--) {
      int ran = Random(key).nextInt(26) + (Random(key).nextBool() ? 65 : 97);
      encrypt = encrypt + (code[i]-ran).toString() + const Utf8Decoder().convert([ran]);
      key = key - 1;
    } 
    return [encrypt, (key+text.length).toString()];
  }

  static String decrypt(String encrypt) {
    final filter = RegExp('[a-zA-Z]');
    List<String> subString = encrypt.split(filter);
    subString.removeAt(subString.length-1);
    List match = filter.allMatches(encrypt).toList();
    List<int> code = [];
    for (int i = match.length-1; i > -1; i--) {
      code.add(const Utf8Encoder().convert(match[i][0])[0] + int.parse(subString[i]));
    }
    return const Utf8Decoder().convert(code);
  }
}