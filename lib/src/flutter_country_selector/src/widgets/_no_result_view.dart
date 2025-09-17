import 'package:flutter/material.dart';
import 'package:phone_number_view/phone_number_view.dart';

class NoResultView extends StatelessWidget {
  final String? title;
  const NoResultView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title ??
            PhoneNumberStringConst.noResultMessage ??
            PhoneNumberStringConst.noResultMessage,
        key: const ValueKey('no-result'),
      ),
    );
  }
}
