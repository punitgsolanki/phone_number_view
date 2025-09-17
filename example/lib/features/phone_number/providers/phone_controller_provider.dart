import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';

/// Provider class to manage phone controller state
class PhoneControllerProvider extends ChangeNotifier {
  late PhoneController _controller;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  PhoneControllerProvider() {
    _controller = PhoneController();
    _controller.addListener(() => notifyListeners());
  }

  // Getters
  PhoneController get controller => _controller;

  FocusNode get focusNode => _focusNode;

  GlobalKey<FormState> get formKey => _formKey;

  /// Reset the form
  void resetForm() {
    _formKey.currentState?.reset();
  }

  /// Select national number and request focus
  void selectNationalNumber() {
    _controller.selectNationalNumber();
    _focusNode.requestFocus();
  }

  /// Set a predefined phone number
  void setPhoneNumber(String phoneNumber) {
    _controller.value = PhoneNumber.parse(phoneNumber);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
