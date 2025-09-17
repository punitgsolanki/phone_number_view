import 'package:phone_number_view/phone_number_view.dart';

abstract class IsoCodeParser {
  /// normalize an iso code to be what the lib expects, mainly uppercases it
  static String normalizeIsoCode(String isoCode) {
    isoCode = isoCode.toUpperCase().trim();
    if (isoCode.length != 2) {
      throw PhoneNumberException(
          code: Code.invalidIsoCode,
          description: "incorrect length, found '$isoCode'");
    }
    return isoCode;
  }
}
