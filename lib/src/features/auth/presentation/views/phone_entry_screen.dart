import 'package:flutter/material.dart';

class PhoneEntryScreen extends StatelessWidget {
  const PhoneEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'We will send a one-time password to your phone.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                prefixText: '+',
              ),
              keyboardType: TextInputType.phone,
            ),
            const Spacer(),
            FilledButton(
              onPressed: () => Navigator.of(context).pushNamed('/verify-phone'),
              child: const Text('Send Code'),
            ),
          ],
        ),
      ),
    );
  }
}
