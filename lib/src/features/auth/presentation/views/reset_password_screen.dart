import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Choose a new password',
      subtitle: 'Use a strong password that you do not use elsewhere.',
      children: [
        AppTextField(
          label: 'New password',
          hint: 'Minimum 8 characters',
          obscureText: _obscureNew,
          prefix: const Icon(Icons.lock_outline_rounded),
          suffix: IconButton(
            onPressed: () => setState(() => _obscureNew = !_obscureNew),
            icon: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          ),
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Confirm password',
          hint: 'Repeat your password',
          obscureText: _obscureConfirm,
          prefix: const Icon(Icons.verified_user_outlined),
          suffix: IconButton(
            onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            icon: Icon(_obscureConfirm ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          ),
        ),
        const SizedBox(height: 24),
        AuthSubmit(
          label: 'Update password',
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.login, (route) => route.isFirst),
        ),
      ],
    );
  }
}

