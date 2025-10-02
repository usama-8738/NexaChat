import 'package:flutter/material.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversation History')),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: 20,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(index),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              color: Colors.redAccent,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              color: Colors.redAccent,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              title: const Text('"Summarize product roadmap"'),
              subtitle: const Text('Updated 2 hours ago - BrainBox AI'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
