import 'package:example/core/constants/string_constants.dart';
import 'package:example/features/phone_number/providers/phone_controller_provider.dart';
import 'package:example/features/phone_number/widgets/phone_action_buttons.dart';
import 'package:example/features/phone_number/widgets/phone_field.dart';
import 'package:example/features/phone_number/widgets/phone_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Main screen widget
/// Now much cleaner as it only contains the layout structure
class PhoneFormFieldScreen extends StatelessWidget {
  const PhoneFormFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringConstants.appTitle)),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Settings panel
                    // const PhoneFieldSettingsPanel(),

                    // const SizedBox(height: 40),

                    // Phone form field
                    Consumer<PhoneControllerProvider>(
                      builder: (context, phoneProvider, child) {
                        return Form(key: phoneProvider.formKey, child: const PhoneField());
                      },
                    ),

                    const SizedBox(height: 12),

                    // Phone info display
                    const PhoneInfo(),

                    const SizedBox(height: 12),

                    // Action buttons
                    const PhoneActionButtons(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
