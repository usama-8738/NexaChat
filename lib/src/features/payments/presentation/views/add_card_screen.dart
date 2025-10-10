import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../shared/widgets/page_header.dart';
import '../../application/payment_methods_providers.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  bool _setAsDefault = true;
  final _cardController = TextEditingController();
  final _holderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listen(paymentMethodsNotifierProvider, (previous, next) {
      if (!mounted) return;
      final wasAdding = previous?.isAdding == true && previous?.isProcessing == true;
      final finishedAdding = previous?.isAdding == true && next.isAdding == false;
      if (next.failure != null && next.failure != previous?.failure) {
        _showMessage(next.failure!.message);
      } else if (wasAdding && finishedAdding && next.failure == null) {
        _showMessage('Card added successfully');
        Navigator.of(context).maybePop();
      }
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _holderController.dispose();
    _expiryController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(paymentMethodsNotifierProvider);
    final notifier = ref.read(paymentMethodsNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
          children: [
            const AppPageHeader(title: 'Add new card'),
            const SizedBox(height: 16),
            _CardPreview(setDefault: _setAsDefault),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 28,
                    offset: Offset(0, 18),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    label: 'Card number',
                    hint: '5698 5626 6786 9979',
                    controller: _cardController,
                    keyboardType: TextInputType.number,
                    prefix: const Icon(Icons.credit_card),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Card holder',
                    hint: 'Tom Hillson',
                    controller: _holderController,
                    prefix: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: 'Expiration date',
                          hint: '05 / 26',
                          controller: _expiryController,
                          prefix: const Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          label: 'CVC',
                          hint: '231',
                          controller: _cvcController,
                          prefix: const Icon(Icons.lock_outline),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Switch(
                        value: _setAsDefault,
                        onChanged: (value) => setState(() => _setAsDefault = value),
                      ),
                      const SizedBox(width: 8),
                      const Text('Set as default payment method'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Save card',
              isLoading: state.isAdding && state.isProcessing,
              onPressed: state.isProcessing
                  ? null
                  : () async {
                      final card = _cardController.text.trim();
                      final holder = _holderController.text.trim();
                      final expiry = _expiryController.text.trim();
                      final cvc = _cvcController.text.trim();

                      final parsed = _parseExpiry(expiry);
                      if (parsed == null) {
                        _showMessage('Invalid expiry. Use MM/YY');
                        return;
                      }
                      if (card.isEmpty || holder.isEmpty || cvc.isEmpty) {
                        _showMessage('Please fill all fields');
                        return;
                      }

                      await notifier.addPaymentMethod(
                        cardNumber: card,
                        holderName: holder,
                        expiryMonth: parsed.$1,
                        expiryYear: parsed.$2,
                        cvv: cvc,
                        setDefault: _setAsDefault,
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }

  (int, int)? _parseExpiry(String value) {
    final cleaned = value.replaceAll(' ', '').replaceAll('-', '').replaceAll('/', '');
    if (cleaned.length < 4) return null;
    final mm = int.tryParse(cleaned.substring(0, 2));
    final yy = int.tryParse(cleaned.substring(2, 4));
    if (mm == null || yy == null) return null;
    if (mm < 1 || mm > 12) return null;
    final fullYear = 2000 + yy;
    return (mm, fullYear);
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview({required this.setDefault});

  final bool setDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF1F2937)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3D000000),
            blurRadius: 40,
            offset: Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.credit_card, color: Colors.white),
              Icon(Icons.more_horiz_rounded, color: Colors.white),
            ],
          ),
          const SizedBox(height: 36),
          const Text(
            '5698 5626 6786 9979',
            style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 2.4),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _CardField(label: 'Card holder', value: 'Name Here'),
              _CardField(label: 'Expires', value: '05/26'),
            ],
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: setDefault ? 1 : 0.4,
            child: Row(
              children: const [
                Icon(Icons.verified, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Text('Default payment method', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardField extends StatelessWidget {
  const _CardField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
