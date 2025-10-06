import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/router/routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../application/auth_providers.dart';
import '../../application/auth_state.dart';
import '../widgets/auth_scaffold.dart';

class PhoneEntryScreen extends ConsumerStatefulWidget {
  const PhoneEntryScreen({super.key});

  @override
  ConsumerState<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends ConsumerState<PhoneEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _countryController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _countryController = TextEditingController(text: '+1');
    _phoneController = TextEditingController();
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (!mounted) return;
      if (next is AuthFailureState && next != previous) {
        _showMessage(next.failure.message);
      } else if (previous is AuthLoading && next is AuthUnauthenticated) {
        final phone = _formattedPhone();
        _showMessage('Verification code sent to $phone');
        Navigator.of(context).pushNamed(AppRoutes.verifyPhone, arguments: phone);
      }
    });
  }

  @override
  void dispose() {
    _countryController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final isLoading = state is AuthLoading;

    return AuthScaffold(
      title: 'Verify your phone',
      subtitle: 'We will send a one-time passcode to authenticate your number.',
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                label: 'Country code',
                hint: '+1',
                controller: _countryController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Country code required';
                  }
                  final normalizedCode = value.trim().startsWith('+') ? value.trim() : '+${value.trim()}';
                  if (!Validators.isValidPhone('${normalizedCode}0000000')) {
                    return 'Enter valid country code';
                  }
                  return null;
                },
                prefix: const Icon(Icons.flag_outlined),
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Phone number',
                hint: '512 555 0147',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number required';
                  }
                  final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (digits.length < 7) {
                    return 'Enter valid phone number';
                  }
                  return null;
                },
                prefix: const Icon(Icons.phone_outlined),
              ),
              const SizedBox(height: 24),
              AuthSubmit(
                label: 'Send code',
                isLoading: isLoading,
                onPressed: isLoading ? null : () => _submit(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formattedPhone() {
    final code = _countryController.text.trim();
    final digits = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final normalizedCode = code.startsWith('+') ? code : '+$code';
    return '$normalizedCode$digits';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final phone = _formattedPhone();
    if (!Validators.isValidPhone(phone)) {
      _showMessage('Enter a valid phone number including country code.');
      return;
    }
    try {
      await ref.read(authNotifierProvider.notifier).sendPhoneCode(phone);
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