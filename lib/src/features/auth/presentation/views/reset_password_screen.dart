import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../application/auth_providers.dart';
import '../../application/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmController;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  String? _token;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmController = TextEditingController();
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (!mounted) return;
      if (next is AuthFailureState && next != previous) {
        _showMessage(next.failure.message);
      } else if (previous is AuthLoading && next is AuthUnauthenticated) {
        _showMessage('Password updated. You can now sign in.');
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _token ??= ModalRoute.of(context)?.settings.arguments as String?;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final isLoading = state is AuthLoading;

    return AuthScaffold(
      title: 'Choose a new password',
      subtitle: 'Use a strong password that you do not use elsewhere.',
      children: [
        if (_token == null)
          const Text('Verification token missing. Please restart the reset flow.')
        else
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTextField(
                  label: 'New password',
                  hint: 'Minimum 8 characters',
                  controller: _passwordController,
                  obscureText: _obscureNew,
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
                    onPressed: () => setState(() => _obscureNew = !_obscureNew),
                    icon: Icon(_obscureNew ? Icons.visibility_off_outlined : Icons.visibility_outlined),
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
                      return 'Please confirm your password';
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
                const SizedBox(height: 24),
                AuthSubmit(
                  label: 'Update password',
                  isLoading: isLoading,
                  onPressed: isLoading ? null : () => _submit(),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_token == null) return;
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      await ref.read(authNotifierProvider.notifier).resetPassword(
            _token!,
            _passwordController.text,
          );
    } catch (_) {
      // handled by listener
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}