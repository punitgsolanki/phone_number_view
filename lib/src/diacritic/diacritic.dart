import 'src/replacement_map.dart';

/// Removes accents and diacritics from the given String.
String removeDiacritics(String text) =>
    String.fromCharCodes(replaceCodeUnits(text.codeUnits));