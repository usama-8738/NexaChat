import 'package:flutter/material.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Invite Your Friends')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Share NexaChat and unlock extra conversation credits when your friends join.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: colorScheme.primaryContainer.withAlpha(77),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'https://nexachat.app/invite/8F2K',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.copy)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FilledButton.tonalIcon(
              onPressed: () {},
              icon: const Icon(Icons.share),
              label: const Text('Share Link'),
            ),
          ],
        ),
      ),
    );
  }
}
