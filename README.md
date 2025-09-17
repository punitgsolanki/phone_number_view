# phone_number_view

A Flutter package for phone number input with international formatting, validation, and country selection. Built on top of phone_form_field with enhanced customization and clean architecture using Provider state management.

[![pub package](https://img.shields.io/pub/v/phone_number_view.svg)](https://pub.dev/packages/phone_number_view)

<img src="https://github.com/punitgsolanki/phone_number_view/blob/main/resources/Screenshot_20250917_152854.png">

<img src="https://github.com/punitgsolanki/phone_number_view/blob/main/resources/Screenshot_20250917_153059.png">

## Features

- 📱 **International phone number input** with automatic formatting
- 🌍 **Country selector** with multiple display options (page, dialog, bottom sheet)
- ✅ **Built-in validation** for mobile and fixed-line numbers
- 🎨 **Highly customizable** appearance and behavior
- 📋 **Auto-fill** and copy-paste support
- 🏗️ **Provider pattern** for clean state management
- 🔧 **Cross-platform** - works on iOS, Android, and Web

## Demo

*Demo available at: [https://github.com/punitgsolanki/phone_number_view/blob/main/resources/app-release.apk]*

![Phone Number View Demo](demo.gif)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  phone_number_view: ^0.0.1
  provider: ^6.1.2  # Optional - Required for state management
```

Then run:

```bash
flutter pub get
```

## Usage

```dart
PhoneNumberView(
  focusNode: myFocusNode,
  controller: myPhoneController,
  isCountryButtonPersistent: true,
  autofocus: false,
  autofillHints: const [AutofillHints.telephoneNumber],
  countrySelectorNavigator: CountrySelectorNavigator.bottomSheet(
    favorites: [IsoCode.IN, IsoCode.US],
  ),
  decoration: InputDecoration(
    label: Text('Phone Number'),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    hintText: 'Enter your phone number',
  ),
  shouldLimitLengthByCountry: true,
  enabled: true,
  countryButtonStyle: CountryButtonStyle(
    showFlag: true,
    showIsoCode: false,
    showDialCode: true,
    showDropdownIcon: true,
    flagSize: 20,
    borderRadius: BorderRadius.circular(8),
  ),
  validator: PhoneValidator.compose([
    PhoneValidator.required(),
    PhoneValidator.validMobile(),
  ]),
  autovalidateMode: AutovalidateMode.onUserInteraction,
  onSaved: (phoneNumber) => debugPrint('Saved: $phoneNumber'),
  onChanged: (phoneNumber) => debugPrint('Changed: $phoneNumber'),
)
```

## Validation

### Built-in Validators

The package provides several built-in validators:

```dart
// Required field validator
PhoneValidator.required()

// General phone number validator
PhoneValidator.valid()

// Mobile number validator
PhoneValidator.validMobile()

// Fixed line validator
PhoneValidator.validFixedLine()

// Country-specific validator
PhoneValidator.validCountry(['US', 'IN'])

// Custom validator
PhoneValidator.compose([
  PhoneValidator.required(errorText: "Phone number is required"),
  PhoneValidator.validMobile(errorText: "Please enter a valid mobile number"),
])
```

### Custom Validators

You can create custom validators:

```dart
PhoneNumberInputValidator customValidator(BuildContext context) {
  return (PhoneNumber? phoneNumber) {
    if (phoneNumber == null || phoneNumber.nsn.isEmpty) {
      return 'Please enter a phone number';
    }
    if (phoneNumber.countryCode != '+1') {
      return 'Only US numbers are allowed';
    }
    return null;
  };
}
```

## Country Selector

### Built-in Country Selectors

Choose from multiple country selector styles:

#### Page Selector
```dart
CountrySelectorNavigator.page()
```

#### Dialog Selector
```dart
CountrySelectorNavigator.dialog(width: 400)
```

#### Bottom Sheet Variants
```dart
// Regular bottom sheet
CountrySelectorNavigator.bottomSheet(
  favorites: [IsoCode.US, IsoCode.IN],
)

// Modal bottom sheet
CountrySelectorNavigator.modalBottomSheet(height: 500)

// Draggable bottom sheet
CountrySelectorNavigator.draggableBottomSheet(
  initialChildSize: 0.6,
  minChildSize: 0.3,
  maxChildSize: 0.9,
)
```

### Custom Country Selector

Create your own country selector:

```dart
class CustomCountrySelectorNavigator implements CountrySelectorNavigator {
  @override
  Future<Country?> show(BuildContext context) async {
    // Implement your custom country selection logic
    return await showCustomCountryPicker(context);
  }
}
```

## Customization

### Country Button Style

```dart
CountryButtonStyle(
  showFlag: true,           // Show country flag
  showIsoCode: false,       // Show ISO country code
  showDialCode: true,       // Show dial code (+1, +44, etc.)
  showDropdownIcon: true,   // Show dropdown arrow
  flagSize: 24,             // Flag icon size
  textStyle: TextStyle(     // Custom text style
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  borderRadius: BorderRadius.circular(8),
)
```

### Input Decoration

Standard Flutter `InputDecoration` is supported:

```dart
decoration: InputDecoration(
  labelText: 'Phone Number',
  hintText: 'Enter your phone number',
  prefixIcon: Icon(Icons.phone),
  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),
)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Setup

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Add tests for your changes
5. Commit your changes (`git commit -m 'Add some amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Dependencies

I took inspiration from these packages:

- [phone_form_field](https://pub.dev/packages/phone_form_field) - Core phone input functionality
- [flutter_country_selector](https://pub.dev/packages/flutter_country_selector) - Country selection
- [phone_numbers_parser](https://pub.dev/packages/phone_numbers_parser) - Phone number parsing and validation
- [provider](https://pub.dev/packages/provider) - State management

## Support

If you find this package helpful, please consider:

- ⭐ Starring the repository
- 🐛 Reporting issues
- 📝 Contributing to the documentation
- 💡 Suggesting new features

For questions and support, please [open an issue](https://github.com/your-username/phone_number_view/issues) on GitHub.

---

**Made with ❤️ for the Flutter community**