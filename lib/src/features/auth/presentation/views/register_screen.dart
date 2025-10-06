import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../domain/entities/oauth_provider.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../application/auth_providers.dart';
import '../../application/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptTerms = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (!mounted) return;
      if (next is AuthFailureState && next != previous) {
        _showMessage(next.failure.message);
      } else if (next is AuthAuthenticated && previous is! AuthAuthenticated) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.phoneEntry);
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final isLoading = state is AuthLoading;

    return AuthScaffold(
      title: 'Create your workspace',
      subtitle: 'Set up your account to unlock the Nexa assistant library.',
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Already have an account? '),
          TextButton(
            onPressed: isLoading
                ? null
                : () => Navigator.of(context).pushReplacementNamed(AppRoutes.login),
            child: const Text('Sign in'),
          ),
        ],
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Full name',
                hint: 'Alex Morgan',
                controller: _nameController,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name is required';
                  }
                  return null;
                },
                prefix: const Icon(Icons.person_outline_rounded),
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Email address',
                hint: 'you@nexachat.ai',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!Validators.isValidEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                prefix: const Icon(Icons.mail_outline_rounded),
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Password',
                hint: 'Minimum 8 characters',
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (!Validators.isStrongPassword(value)) {
                    return 'Use at least 8 characters with numbers and uppercase letters';
                  }
                  return null;
                },
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
                controller: _confirmController,
                obscureText: _obscureConfirm,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
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
                    onChanged: isLoading ? null : (value) => setState(() => _acceptTerms = value ?? false),
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
                isLoading: isLoading,
                onPressed: isLoading ? null : () => _submit(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AppButton(
          label: 'Continue with Google',
          variant: AppButtonVariant.secondary,
          leading: const Icon(Icons.g_mobiledata, size: 32),
          onPressed: isLoading
              ? null
              : () => ref.read(authNotifierProvider.notifier).loginWithSocial(
                    OAuthProvider.google,
                    'TODO_ACCESS_TOKEN',
                  ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (!_acceptTerms) {
      _showMessage('You must accept the terms to continue.');
      return;
    }
    try {
      await ref.read(authNotifierProvider.notifier).register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            fullName: _nameController.text.trim(),
          );
    } catch (_) {
      // Errors handled in listener
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}