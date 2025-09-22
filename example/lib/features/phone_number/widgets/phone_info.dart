import 'package:example/core/constants/string_constants.dart';
import 'package:example/features/phone_number/providers/phone_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';
import 'package:provider/provider.dart';

/// Phone information display widget
/// Shows current phone number state and validation results
class PhoneInfo extends StatelessWidget {
  const PhoneInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PhoneControllerProvider>(
      builder: (context, phoneProvider, child) {
        return Column(
          children: [
            const SizedBox(height: 16,),

            // Current phone number value
            Text(phoneProvider.controller.value.toString(), style: Theme.of(context).textTheme.bodyMedium),

            const SizedBox(height: 16,),

            // Mobile number validation
            Text(
              '${StringConstants.isValidMobileNumber} '
              '${phoneProvider.controller.value.isValid(type: PhoneNumberType.mobile)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 16,),

            // Fixed line validation
            Text(
              '${StringConstants.isValidFixedLineNumber} '
              '${phoneProvider.controller.value.isValid(type: PhoneNumberType.fixedLine)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }
}
