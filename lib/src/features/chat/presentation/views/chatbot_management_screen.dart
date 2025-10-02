import 'package:flutter/material.dart';

class ChatbotManagementScreen extends StatelessWidget {
  const ChatbotManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Assistants')),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primary.withAlpha(26),
                child: Icon(Icons.smart_toy, color: primary),
              ),
              title: Text('Assistant ${index + 1}'),
              subtitle: const Text('Tap to configure instructions and tone'),
              trailing: Switch(value: index.isEven, onChanged: (_) {}),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
