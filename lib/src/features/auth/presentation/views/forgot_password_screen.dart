import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Reset your password',
      subtitle: 'Enter the email linked to your account and we will send reset instructions.',
      children: [
        AppTextField(
          label: 'Email address',
          hint: 'you@nexachat.ai',
          keyboardType: TextInputType.emailAddress,
          prefix: const Icon(Icons.mail_outline_rounded),
        ),
        const SizedBox(height: 24),
        AuthSubmit(
          label: 'Send reset link',
          onPressed: () => Navigator.of(context).pushNamed('/reset-password'),
        ),
      ],
    );
  }
}

