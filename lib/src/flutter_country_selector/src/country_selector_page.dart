import 'package:flutter/material.dart';
import '../../core/resources/phone_number_string_const.dart';
import '../flutter_country_selector.dart';
import 'widgets/_country_list_view.dart';
import 'widgets/_search_box.dart';

/// Same as [CountrySelectorSheet] but designed as a full page
class CountrySelectorPage extends CountrySelectorBase {
  const CountrySelectorPage({
    super.key,
    required super.onCountrySelected,
    super.scrollController,
    super.scrollPhysics,
    super.showDialCode,
    super.noResultMessage,
    super.favoriteCountries,
    super.countries,
    super.searchAutofocus,
    super.subtitleStyle,
    super.titleStyle,
    super.searchBoxDecoration,
    super.searchBoxTextStyle,
    super.searchBoxIconColor,
    super.flagSize,
  });

  @override
  CountrySelectorPageState createState() => CountrySelectorPageState();
}

class CountrySelectorPageState extends CountrySelectorBaseState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Theme.of(context).colorScheme.shadow,
        title: SearchBox(
          autofocus: widget.searchAutofocus,
          onChanged: onSearch,
          onSubmitted: onSubmitted,
          decoration: widget.searchBoxDecoration ??
              const InputDecoration(
                border: InputBorder.none,
                hintText: PhoneNumberStringConst.search,
              ),
          style: widget.searchBoxTextStyle,
          searchIconColor: widget.searchBoxIconColor,
        ),
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return CountryListView(
            countries: controller.filteredCountries,
            favorites: controller.filteredFavorites,
            showDialCode: widget.showDialCode,
            onTap: (country) => widget.onCountrySelected(country.isoCode),
            flagSize: widget.flagSize,
            scrollController: widget.scrollController,
            scrollPhysics: widget.scrollPhysics,
            noResultMessage: widget.noResultMessage,
            titleStyle: widget.titleStyle,
            subtitleStyle: widget.subtitleStyle,
          );
        },
      ),
    );
  }
}
