import 'package:example/core/constants/string_constants.dart';
import 'package:example/features/phone_number/providers/phone_field_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';
import 'package:provider/provider.dart';

/// Settings panel widget for configuring phone field options
/// Separated for better organization and maintainability
class PhoneFieldSettings extends StatelessWidget {
  const PhoneFieldSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneFieldSettingsProvider>(
      builder: (context, settings, child) {
        return Column(
          children: [
            // Outline border toggle
            SwitchListTile(
              value: settings.outlineBorder,
              onChanged: settings.setOutlineBorder,
              title: const Text(StringConstants.outlinedBorder),
            ),

            // Label toggle
            SwitchListTile(value: settings.withLabel, onChanged: settings.setWithLabel, title: const Text(StringConstants.label)),

            // Persistent country chip toggle
            SwitchListTile(
              value: settings.isCountryButtonPersistent,
              onChanged: settings.setCountryButtonPersistent,
              title: const Text(StringConstants.persistentCountryChip),
            ),

            // Mobile only toggle
            SwitchListTile(
              value: settings.mobileOnly,
              onChanged: settings.setMobileOnly,
              title: const Text(StringConstants.mobilePhoneOnly),
            ),

            // Country selector dropdown
            ListTile(
              title: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(StringConstants.countrySelector),
                  DropdownButton<CountrySelectorNavigator>(
                    value: settings.selectorNavigator,
                    onChanged: (CountrySelectorNavigator? value) {
                      if (value != null) {
                        settings.setSelectorNavigator(value);
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: CountrySelectorNavigator.bottomSheet(favorites: [IsoCode.IN, IsoCode.US]),
                        child: Text(StringConstants.bottomSheet),
                      ),
                      DropdownMenuItem(
                        value: CountrySelectorNavigator.draggableBottomSheet(),
                        child: Text(StringConstants.draggableModelSheet),
                      ),
                      DropdownMenuItem(value: CountrySelectorNavigator.modalBottomSheet(), child: Text(StringConstants.modelSheet)),
                      DropdownMenuItem(value: CountrySelectorNavigator.dialog(width: 720), child: Text(StringConstants.dialog)),
                      DropdownMenuItem(value: CountrySelectorNavigator.page(), child: Text(StringConstants.page)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
