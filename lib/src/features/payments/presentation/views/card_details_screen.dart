import 'package:flutter/material.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Details')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.primaryContainer,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('**** **** **** 8291',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  SizedBox(height: 12),
                  Text('Sulem Freelancer',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Exp. 08/28', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.lock_clock),
              title: const Text('Set spending limit'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Billing reminders'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(backgroundColor: Colors.redAccent),
              child: const Text('Remove Card'),
            ),
          ],
        ),
      ),
    );
  }
}
