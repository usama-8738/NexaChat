import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      {
        'title': 'Content Studio',
        'description': 'Create viral-ready scripts for social media.'
      },
      {
        'title': 'Health Coach',
        'description': 'Personalised routines and diet AI for wellness.'
      },
      {
        'title': 'Growth Mentor',
        'description': 'Insights to scale your business and brand.'
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('AI Services')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final service = services[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service['title']!, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(service['description']!),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('View Playbooks'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
