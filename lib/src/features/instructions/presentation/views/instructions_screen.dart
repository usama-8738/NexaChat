import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'TikTok': [
        'Hook your audience with a bold question.',
        'Summarise the core idea in under 15 seconds.',
        'End with a clear call-to-action tailored for TikTok.'
      ],
      'Telegram': [
        'Introduce the bot and its personality.',
        'Highlight quick commands your community can try.',
        'Invite users to share feedback for improvements.'
      ],
      'Health': [
        'Clarify that advice is not medical diagnosis.',
        'Include hydration and rest reminders.',
        'Offer follow-up prompts to keep users engaged.'
      ],
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assistant Instructions'),
          bottom: TabBar(
            isScrollable: true,
            tabs: tabs.keys.map((key) => Tab(text: key)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.values.map((items) {
            return ListView.separated(
              padding: const EdgeInsets.all(24),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(items[index]),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: items.length,
            );
          }).toList(),
        ),
      ),
    );
  }
}
