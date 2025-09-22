import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../circle_flags/circle_flags.dart';
import '../../phone_numbers_parser/phone_numbers_parser.dart';
import '../flutter_country_selector.dart';

abstract class CountrySelector {
  /// on the web, will download flag assets in memory.
  /// If you do not specify an iso code, will download all flag assets.
  static Future<void> preloadFlags({Iterable<IsoCode>? isoCodes}) {
    isoCodes ??= IsoCode.values;
    return CircleFlag.preload(isoCodes.map((isoCode) => isoCode.name));
  }

  /// Use [CountrySelector.page] if you need to show the selector inside
  /// a widget that is full screen. If you need to show the selector inside
  /// a modal of some sort, use [CountrySelector.sheet] instead.
  static page({
    required void Function(IsoCode) onCountrySelected,
    List<IsoCode>? countries = IsoCode.values,
    List<IsoCode>? favoriteCountries,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    bool? showDialCode,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    double? flagSize,
  }) {
    return CountrySelectorPage(
      onCountrySelected: onCountrySelected,
      countries: countries,
      favoriteCountries: favoriteCountries,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      showDialCode: showDialCode,
      noResultMessage: noResultMessage,
      searchAutofocus: searchAutofocus,
      subtitleStyle: subtitleStyle,
      titleStyle: titleStyle,
      searchBoxDecoration: searchBoxDecoration,
      searchBoxTextStyle: searchBoxTextStyle,
      searchBoxIconColor: searchBoxIconColor,
      flagSize: flagSize,
    );
  }

  /// Use [CountrySelector.sheet] if you need to show the selector inside
  /// a widget that is not full screen. If you need to show the selector
  /// as a full page, use [CountrySelector.page]
  static dynamic sheet({
    required void Function(IsoCode) onCountrySelected,
    List<IsoCode> countries = IsoCode.values,
    List<IsoCode> favoriteCountries = const [],
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    bool addFavoritesSeparator = true,
    bool showDialCode = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
    TextStyle? subtitleStyle,
    TextStyle? titleStyle,
    InputDecoration? searchBoxDecoration,
    TextStyle? searchBoxTextStyle,
    Color? searchBoxIconColor,
    double? flagSize,
  }) {
    return CountrySelectorSheet(
      onCountrySelected: onCountrySelected,
      countries: countries,
      favoriteCountries: favoriteCountries,
      scrollController: scrollController,
      scrollPhysics: scrollPhysics,
      showDialCode: showDialCode,
      noResultMessage: noResultMessage,
      searchAutofocus: searchAutofocus,
      subtitleStyle: subtitleStyle,
      titleStyle: titleStyle,
      searchBoxDecoration: searchBoxDecoration,
      searchBoxTextStyle: searchBoxTextStyle,
      searchBoxIconColor: searchBoxIconColor,
      flagSize: flagSize,
    );
  }
}
