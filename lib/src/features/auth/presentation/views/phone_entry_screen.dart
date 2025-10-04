import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class PhoneEntryScreen extends StatelessWidget {
  const PhoneEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Verify your phone',
      subtitle: 'We will send a one-time passcode to authenticate your number.',
      children: [
        AppTextField(
          label: 'Country code',
          hint: '+1',
          keyboardType: TextInputType.phone,
          prefix: const Icon(Icons.flag_outlined),
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Phone number',
          hint: '512 555 0147',
          keyboardType: TextInputType.phone,
          prefix: const Icon(Icons.phone_outlined),
        ),
        const SizedBox(height: 24),
        AuthSubmit(
          label: 'Send code',
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.verifyPhone),
        ),
      ],
    );
  }
}

