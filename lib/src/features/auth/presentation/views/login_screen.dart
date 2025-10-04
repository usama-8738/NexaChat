import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../widgets/auth_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to continue building with your copilots.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          TextButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.register),
            child: const Text('Create account'),
          ),
        ],
      ),
      children: [
        AppTextField(
          label: 'Email address',
          hint: 'you@nexachat.ai',
          keyboardType: TextInputType.emailAddress,
          prefix: const Icon(Icons.mail_outline_rounded),
        ),
        const SizedBox(height: 20),
        AppTextField(
          label: 'Password',
          hint: 'Enter your password',
          obscureText: _obscurePassword,
          prefix: const Icon(Icons.lock_outline_rounded),
          suffix: IconButton(
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            icon: Icon(
              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (value) => setState(() => _rememberMe = value ?? true),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            ),
            const Text('Remember me'),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(AppRoutes.forgotPassword),
              child: const Text('Forgot password?'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AuthSubmit(
          label: 'Sign in',
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.home),
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

