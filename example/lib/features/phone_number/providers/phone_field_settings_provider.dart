// =====================================================
// PROVIDER CLASSES
// =====================================================

import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';

/// Provider class to manage phone field configuration state
/// This eliminates the need for setState calls
class PhoneFieldSettingsProvider extends ChangeNotifier {
  bool _outlineBorder = true;
  bool _mobileOnly = true;
  bool _isCountryButtonPersistent = true;
  bool _withLabel = true;
  CountrySelectorNavigator _selectorNavigator = const CountrySelectorNavigator.bottomSheet(favorites: [IsoCode.US, IsoCode.IN]);

  // Getters
  bool get outlineBorder => _outlineBorder;

  bool get mobileOnly => _mobileOnly;

  bool get isCountryButtonPersistent => _isCountryButtonPersistent;

  bool get withLabel => _withLabel;

  CountrySelectorNavigator get selectorNavigator => _selectorNavigator;

  // Setters with notification
  void setOutlineBorder(bool value) {
    _outlineBorder = value;
    notifyListeners();
  }

  void setMobileOnly(bool value) {
    _mobileOnly = value;
    notifyListeners();
  }

  void setCountryButtonPersistent(bool value) {
    _isCountryButtonPersistent = value;
    notifyListeners();
  }

  void setWithLabel(bool value) {
    _withLabel = value;
    notifyListeners();
  }

  void setSelectorNavigator(CountrySelectorNavigator value) {
    _selectorNavigator = value;
    notifyListeners();
  }
}
