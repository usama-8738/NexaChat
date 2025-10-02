import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Subscriptions')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose the plan that fits your workflow',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final bool isPopular = index == 1;
                  return Card(
                    elevation: isPopular ? 4 : 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Pro ${index + 1}',
                                  style: Theme.of(context).textTheme.titleLarge),
                              if (isPopular) ...[
                                const SizedBox(width: 12),
                                Chip(
                                  backgroundColor: colorScheme.primary.withAlpha(31),
                                  label: const Text('Most Popular'),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Text('Unlimited chats - Priority support - Team workspaces'),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () {},
                            child: const Text('Select'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemCount: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
