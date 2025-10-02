import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _pushNotifications = true;
  bool _emailUpdates = false;
  String _defaultAssistant = 'BrainBox';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preferences')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
          SwitchListTile(
            title: const Text('Push notifications'),
            subtitle: const Text('Get alerts when assistants complete tasks'),
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          SwitchListTile(
            title: const Text('Email updates'),
            subtitle: const Text('Weekly summaries and new templates'),
            value: _emailUpdates,
            onChanged: (value) => setState(() => _emailUpdates = value),
          ),
          const SizedBox(height: 16),
          const Text('Defaults', style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownMenu<String>(
            initialSelection: _defaultAssistant,
            label: const Text('Primary assistant'),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'BrainBox', label: 'BrainBox AI'),
              DropdownMenuEntry(value: 'Athena', label: 'Athena Knowledge'),
              DropdownMenuEntry(value: 'Pulse', label: 'Pulse Coach'),
            ],
            onSelected: (value) {
              if (value != null) {
                setState(() => _defaultAssistant = value);
              }
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {},
            child: const Text('Save Preferences'),
          ),
        ],
      ),
    );
  }
}
