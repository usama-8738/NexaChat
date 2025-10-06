import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../application/auth_providers.dart';
import '../../application/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  const VerifyCodeScreen({super.key, this.isPhoneFlow = true});

  final bool isPhoneFlow;

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  String _code = '';
  String? _target;

  @override
  void initState() {
    super.initState();
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (!mounted) return;
      if (next is AuthFailureState && next != previous) {
        _showMessage(next.failure.message);
      } else if (previous is AuthLoading && next is AuthUnauthenticated) {
        if (widget.isPhoneFlow) {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.resetPassword, arguments: _code);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _target = args;
    } else if (args is Map && args['target'] is String) {
      _target = args['target'] as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    final prompt = widget.isPhoneFlow
        ? 'Enter the 6-digit passcode sent to your phone number.'
        : 'Enter the 6-digit passcode delivered to your inbox.';
    final state = ref.watch(authNotifierProvider);
    final isLoading = state is AuthLoading;

    return AuthScaffold(
      title: 'Verify code',
      subtitle: prompt,
      children: [
        AppOtpField(
          length: 6,
          onCompleted: (value) => setState(() => _code = value),
        ),
        const SizedBox(height: 24),
        AuthSubmit(
          label: 'Verify and continue',
          isLoading: isLoading,
          onPressed: !isLoading && _code.length == 6 ? () => _submit() : null,
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: isLoading ? null : _resend,
          child: const Text('Resend code'),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    try {
      await ref.read(authNotifierProvider.notifier).verify(
            code: _code,
            isPhoneFlow: widget.isPhoneFlow,
          );
    } catch (_) {
      // handled by listener
    }
  }

  Future<void> _resend() async {
    if (widget.isPhoneFlow) {
      final target = _target;
      if (target == null) {
        _showMessage('Phone number missing. Please restart verification.');
        return;
      }
      try {
        await ref.read(authNotifierProvider.notifier).sendPhoneCode(target);
      } catch (_) {
        // handled by listener
      }
    } else {
      _showMessage('Check your email inbox for the latest code.');
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}