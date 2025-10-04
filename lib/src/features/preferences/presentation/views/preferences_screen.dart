import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _pushNotifications = true;
  bool _emailUpdates = false;
  bool _weeklyDigest = true;
  String _defaultAssistant = 'BrainBox';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 140),
          children: [
            AppPageHeader(
              title: 'Preferences',
              subtitle: Text(
                'Tune notifications, defaults and assistant behaviour.',
                style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 12),
            _SwitchCard(
              title: 'Push notifications',
              description: 'Get alerts when assistants finish tasks or need input.',
              value: _pushNotifications,
              onChanged: (value) => setState(() => _pushNotifications = value),
            ),
            const SizedBox(height: 12),
            _SwitchCard(
              title: 'Email updates',
              description: 'Weekly highlights on conversation summaries and releases.',
              value: _emailUpdates,
              onChanged: (value) => setState(() => _emailUpdates = value),
            ),
            const SizedBox(height: 12),
            _SwitchCard(
              title: 'Weekly digest',
              description: 'Every Monday receive a digest of workspace insights.',
              value: _weeklyDigest,
              onChanged: (value) => setState(() => _weeklyDigest = value),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 24,
                    offset: Offset(0, 18),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Primary assistant',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  DropdownMenu<String>(
                    initialSelection: _defaultAssistant,
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
                  const SizedBox(height: 16),
                  Text(
                    'This assistant will be used by default for quick prompts and shortcuts.',
                    style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Save preferences',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchCard extends StatelessWidget {
  const _SwitchCard({
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 24,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

