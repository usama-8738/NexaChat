import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_textfield.dart';
import '../../../../shared/widgets/page_header.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool _setAsDefault = true;

  @override
  Widget build(BuildContext context) {
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
                    keyboardType: TextInputType.number,
                    prefix: const Icon(Icons.credit_card),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Card holder',
                    hint: 'Tom Hillson',
                    prefix: const Icon(Icons.person_outline),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Expanded(
                        child: AppTextField(
                          label: 'Expiration date',
                          hint: '05 / 26',
                          prefix: Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(
                          label: 'CVC',
                          hint: '231',
                          prefix: Icon(Icons.lock_outline),
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
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

