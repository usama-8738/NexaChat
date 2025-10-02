import 'package:flutter/material.dart';

class WelcomeHomeScreen extends StatelessWidget {
  const WelcomeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome Home')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Choose an assistant to get started',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: List.generate(4, (index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: primary.withAlpha(26),
                              child: Icon(Icons.smart_toy, color: primary),
                            ),
                            const Spacer(),
                            Text('Assistant ${index + 1}',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 4),
                            const Text('Tap to explore', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
