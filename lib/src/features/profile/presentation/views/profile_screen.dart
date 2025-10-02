import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 36, child: Icon(Icons.person)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sulem Freelancer', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Premium Member', style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          const ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Payment methods'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.lock_outline),
            title: Text('Security & privacy'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.analytics_outlined),
            title: Text('Usage analytics'),
            trailing: Icon(Icons.chevron_right),
          ),
          const SizedBox(height: 32),
          FilledButton.tonal(
            onPressed: () {},
            child: const Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}
