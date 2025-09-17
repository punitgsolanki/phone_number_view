import '../../../diacritic/diacritic.dart';
import '../../../phone_numbers_parser/phone_numbers_parser.dart';

class SearchableCountry {
  /// Country alpha-2 iso code
  final IsoCode isoCode;

  /// localized name of the country
  final String name;

  /// lower case name with diacritics removed
  final String searchableName;

  /// country dialing code to call them internationally
  final String dialCode;

  /// returns "+ [dialCode]"
  String get formattedCountryDialingCode => '+ $dialCode';

  SearchableCountry(this.isoCode, this.dialCode, this.name)
      : searchableName = removeDiacritics(name.toLowerCase());

  @override
  String toString() {
    return '$runtimeType(isoCode: $isoCode, dialCode: $dialCode, name: $name)';
  }
}
