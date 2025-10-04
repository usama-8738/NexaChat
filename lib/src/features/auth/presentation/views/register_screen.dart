import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptTerms = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Create your workspace',
      subtitle: 'Set up your account to unlock the Nexa assistant library.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? '),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            child: const Text('Sign in'),
          ),
        ],
      ),
      children: [
        AppTextField(
          label: 'Full name',
          hint: 'Alex Morgan',
          prefix: const Icon(Icons.person_outline_rounded),
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Email address',
          hint: 'you@nexachat.ai',
          keyboardType: TextInputType.emailAddress,
          prefix: const Icon(Icons.mail_outline_rounded),
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Password',
          hint: 'Minimum 8 characters',
          obscureText: _obscurePassword,
          prefix: const Icon(Icons.lock_outline_rounded),
          suffix: IconButton(
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined),
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
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _acceptTerms,
              onChanged: (value) => setState(() => _acceptTerms = value ?? false),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'I agree to the ',
                  children: [
                    TextSpan(
                      text: 'Terms of Service ',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: 'and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AuthSubmit(
          label: 'Create account',
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.phoneEntry),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Continue with Google',
          variant: AppButtonVariant.secondary,
          leading: const Icon(Icons.g_mobiledata, size: 32),
          onPressed: () {},
        ),
      ],
    );
  }
}

