import 'package:example/core/constants/string_constants.dart';
import 'package:example/features/phone_number/providers/phone_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Action buttons widget
/// Contains all action buttons for phone field operations
class PhoneActionButtons extends StatelessWidget {
  const PhoneActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneControllerProvider>(
      builder: (context, phoneProvider, child) {
        return Column(
          children: [
            // Reset button
            ElevatedButton(onPressed: phoneProvider.resetForm, child: const Text(StringConstants.reset)),

            const SizedBox(height: 12),

            // Select national number button
            ElevatedButton(onPressed: phoneProvider.selectNationalNumber, child: const Text(StringConstants.selectNationalNumber)),

            const SizedBox(height: 12),

            // Set predefined number button
            ElevatedButton(
              onPressed: () => phoneProvider.setPhoneNumber(StringConstants.defaultPhoneNumber),
              child: const Text(StringConstants.setPredefinedNumber),
            ),
          ],
        );
      },
    );
  }
}
