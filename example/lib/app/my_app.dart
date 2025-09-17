import 'package:example/features/phone_number/providers/phone_controller_provider.dart';
import 'package:example/features/phone_number/providers/phone_field_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhoneFieldSettingsProvider()),
        ChangeNotifierProvider(create: (_) => PhoneControllerProvider()),
      ],
      child: const App(),
    );
  }
}
