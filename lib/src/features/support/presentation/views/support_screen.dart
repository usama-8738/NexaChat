import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Support')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.chat_bubble_outline),
              title: const Text('Live chat'),
              subtitle: const Text('Chat with our experts 24/7'),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.book_outlined),
              title: const Text('Knowledge base'),
              subtitle: const Text('Browse tutorials and FAQs'),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text('Email support'),
              subtitle: const Text('support@nexachat.ai'),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
