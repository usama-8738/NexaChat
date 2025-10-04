import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key, this.isPhoneFlow = true});

  final bool isPhoneFlow;

  @override
  Widget build(BuildContext context) {
    final prompt = isPhoneFlow
        ? 'Enter the 6-digit passcode sent to your phone number.'
        : 'Enter the 6-digit passcode delivered to your inbox.';

    return AuthScaffold(
      title: 'Verify code',
      subtitle: prompt,
      children: [
        const AppOtpField(length: 6),
        const SizedBox(height: 24),
        AuthSubmit(
          label: 'Verify and continue',
          onPressed: () => Navigator.of(context).pushReplacementNamed(
            isPhoneFlow ? AppRoutes.verifyEmail : AppRoutes.home,
          ),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {},
          child: const Text('Resend code'),
        ),
      ],
    );
  }
}

