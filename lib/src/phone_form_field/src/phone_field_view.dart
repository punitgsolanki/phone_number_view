// =====================================================
// MAIN LIBRARY FILE - phone_field.dart
// =====================================================

/// A comprehensive Flutter package for international phone number input
/// with validation, formatting, and country selection capabilities.
///
/// This library provides a clean, customizable phone number input widget
/// built on top of phone_form_field with enhanced features and Provider
/// state management integration.
///
/// ## Features
///
/// * International phone number formatting
/// * Multiple country selector options
/// * Built-in validation system
/// * Provider state management
/// * Accessibility support
/// * Cross-platform compatibility
///
/// ## Basic Usage
///
/// ```dart
/// PhoneNumberView(
///   onChanged: (phoneNumber) => print('Phone: $phoneNumber'),
///   validator: PhoneValidator.validMobile(),
/// )
/// ```

library;

// Export all public APIs with documentation
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_number_view/phone_number_view.dart';
import 'package:phone_number_view/src/phone_form_field/src/phone_field_semantics.dart';
import 'package:phone_number_view/src/phone_form_field/src/validation/allowed_characters.dart';

import 'package:phone_number_view/src/phone_form_field/src/validation/limit_max_length_formatter.dart';

import '../../phone_numbers_parser/metadata.dart';

part 'phone_controller.dart';
part 'phone_form_field_state.dart';

// =====================================================
// PHONE NUMBER VIEW WIDGET
// =====================================================

/// A customizable phone number input widget with international support.
///
/// This widget provides a comprehensive solution for phone number input
/// with automatic formatting, validation, and country selection. It uses
/// Provider pattern for clean state management.
///
/// ## Features
///
/// * Automatic phone number formatting based on country
/// * Multiple country selector UI options
/// * Built-in and custom validation support
/// * Provider-based state management
/// * Accessibility and internationalization support
/// * Cross-platform compatibility
///
/// ## Example
///
/// ```dart
/// PhoneNumberView(
///   controller: myPhoneController,
///   focusNode: myFocusNode,
///   decoration: InputDecoration(
///     labelText: 'Phone Number',
///     border: OutlineInputBorder(),
///   ),
///   validator: PhoneValidator.compose([
///     PhoneValidator.required(),
///     PhoneValidator.validMobile(),
///   ]),
///   onChanged: (phoneNumber) {
///     print('Phone number changed: $phoneNumber');
///   },
///   countrySelectorNavigator: CountrySelectorNavigator.bottomSheet(),
/// )
/// ```
///
/// See also:
///
/// * [PhoneController] for managing phone number state
/// * [PhoneValidator] for validation options
/// * [CountrySelectorNavigator] for country selection methods
class PhoneFormField extends FormField<PhoneNumber> {
  /// {@macro controller}
  final PhoneController? controller;

  /// callback called when the input value changes
  final Function(PhoneNumber)? onChanged;

  /// the focusNode of the national number
  final FocusNode? focusNode;

  /// how to display the country selection
  final CountrySelectorNavigator countrySelectorNavigator;

  /// whether the user can select a new country when pressing the country button
  final bool isCountrySelectionEnabled;

  /// This controls wether the country button is alway shown or is hidden by
  /// the label when the national number is empty. In flutter terms this controls
  /// whether the country button is shown as a prefix or prefixIcon inside
  /// the text field.
  final bool isCountryButtonPersistent;

  /// The style of the country selector button
  final CountryButtonStyle countryButtonStyle;

  // TextField inputs
  final InputDecoration decoration;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;
  final bool? showCursor;
  final Function()? onEditingComplete;
  final Function(PhoneNumber)? onSubmitted;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final Function(PointerDownEvent)? onTapOutside;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  bool get selectionEnabled => enableInteractiveSelection;
  final MouseCursor? mouseCursor;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final bool enableIMEPersonalizedLearning;
  final List<TextInputFormatter>? inputFormatters;
  final bool shouldLimitLengthByCountry;

  static Future<void> preloadFlags() async => CircleFlag.preload(Flags.values);

  PhoneFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.countrySelectorNavigator = const CountrySelectorNavigator.page(),
    this.isCountrySelectionEnabled = true,
    this.isCountryButtonPersistent = true,
    this.countryButtonStyle = const CountryButtonStyle(),
    // form field inputs
    super.validator,
    PhoneNumber? initialValue,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.onUserInteraction,
    super.restorationId,
    super.enabled = true,
    // textfield inputs
    this.decoration = const InputDecoration(),
    this.keyboardType = TextInputType.phone,
    this.textInputAction,
    this.style,
    this.strutStyle,
    @Deprecated('Has no effect, Change text directionality instead')
    this.textAlign,
    this.textAlignVertical,
    this.autofocus = false,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
    this.contextMenuBuilder,
    this.showCursor,
    this.onEditingComplete,
    this.onSubmitted,
    this.onAppPrivateCommand,
    this.onTapOutside,
    this.inputFormatters,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.mouseCursor,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.enableIMEPersonalizedLearning = true,
    this.shouldLimitLengthByCountry = false,
  })  : assert(
          initialValue == null || controller == null,
          'One of initialValue or controller can be specified at a time',
        ),
        super(
          builder: (state) => (state as PhoneFormFieldState).builder(),
          initialValue: controller?.value ?? initialValue,
        );

  @override
  PhoneFormFieldState createState() => PhoneFormFieldState();
}
