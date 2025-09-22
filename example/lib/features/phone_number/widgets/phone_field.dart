import 'package:example/core/constants/string_constants.dart';
import 'package:example/features/phone_number/providers/phone_controller_provider.dart';
import 'package:example/features/phone_number/providers/phone_field_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';
import 'package:provider/provider.dart';

/// Custom phone field widget with validation
/// Separated for better code organization and reusability
class PhoneField extends StatelessWidget {
  const PhoneField({super.key});

  /// Get validator based on mobile-only setting
  PhoneNumberInputValidator? _getValidator(BuildContext context, bool mobileOnly) {
    List<PhoneNumberInputValidator> validators = [];
    if (mobileOnly) {
      validators.add(PhoneValidator.validMobile(context));
    } else {
      validators.add(PhoneValidator.valid(context));
    }
    return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PhoneFieldSettingsProvider, PhoneControllerProvider>(
      builder: (context, settings, phoneProvider, child) {
        return AutofillGroup(
          child: PhoneFormField(
            focusNode: phoneProvider.focusNode,
            controller: phoneProvider.controller,
            isCountryButtonPersistent: settings.isCountryButtonPersistent,
            autofocus: false,
            autofillHints: const [AutofillHints.telephoneNumber],
            countrySelectorNavigator: settings.selectorNavigator,
            decoration: InputDecoration(
              label: settings.withLabel ? const Text(StringConstants.phoneNumberLabel) : null,
              border:
                  settings.outlineBorder
                      ? OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                      : const UnderlineInputBorder(),
              hintText: settings.withLabel ? '' : StringConstants.phoneNumberLabel,
              contentPadding: const EdgeInsets.all(0),
            ),
            shouldLimitLengthByCountry: true,
            enabled: true,
            countryButtonStyle: CountryButtonStyle(
              showFlag: true,
              showIsoCode: false,
              showDialCode: true,
              showDropdownIcon: true,
              borderRadius: BorderRadius.circular(50),
            ),
            validator: _getValidator(context, settings.mobileOnly),
            autovalidateMode: AutovalidateMode.disabled,
            cursorColor: Theme.of(context).colorScheme.primary,
            onSaved: (phoneNumber) => debugPrint('Saved: $phoneNumber'),
            onChanged: (phoneNumber) => debugPrint('Changed: $phoneNumber'),
          ),
        );
      },
    );
  }
}
