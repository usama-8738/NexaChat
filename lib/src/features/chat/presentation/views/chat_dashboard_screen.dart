import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';

class ChatDashboardScreen extends StatelessWidget {
  const ChatDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BrainBox Assistants'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('New Chat'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primary.withAlpha(26),
                child: Icon(Icons.smart_toy, color: primary),
              ),
              title: Text('Assistant ${index + 1}'),
              subtitle: const Text('Tap to continue the conversation'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).pushNamed(AppRoutes.chatRoom),
            ),
          );
        },
      ),
    );
  }
}
