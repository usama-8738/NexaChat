import 'package:flutter/material.dart';

class CardSettingsScreen extends StatefulWidget {
  const CardSettingsScreen({super.key});

  @override
  State<CardSettingsScreen> createState() => _CardSettingsScreenState();
}

class _CardSettingsScreenState extends State<CardSettingsScreen> {
  bool _autoPay = true;
  bool _notifications = true;
  double _limit = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: _autoPay,
              title: const Text('Enable auto-pay'),
              subtitle: const Text('Automatically charge this card for renewals'),
              onChanged: (value) => setState(() => _autoPay = value),
            ),
            SwitchListTile(
              value: _notifications,
              title: const Text('Payment notifications'),
              subtitle: const Text('Get real-time alerts for payments'),
              onChanged: (value) => setState(() => _notifications = value),
            ),
            const SizedBox(height: 16),
            Text('Monthly limit: \$${_limit.toStringAsFixed(0)}'),
            Slider(
              min: 100,
              max: 1000,
              divisions: 9,
              value: _limit,
              label: '\$${_limit.toStringAsFixed(0)}',
              onChanged: (value) => setState(() => _limit = value),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: const Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}