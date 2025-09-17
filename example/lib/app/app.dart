import 'package:example/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import '../features/phone_number/screens/phone_form_field_screen.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConstants.appTitle,
      theme: AppTheme.darkTheme,
      home: const PhoneFormFieldScreen(),
    );
  }
}
