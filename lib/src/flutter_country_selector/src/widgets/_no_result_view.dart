import 'package:flutter/material.dart';

import '../../../core/resources/phone_number_string_const.dart';

class NoResultView extends StatelessWidget {
  final String? title;
  const NoResultView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title ?? PhoneNumberStringConst.noResultMessage,
        key: const ValueKey('no-result'),
      ),
    );
  }
}
