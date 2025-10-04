import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class ChatbotManagementScreen extends StatefulWidget {
  const ChatbotManagementScreen({super.key});

  @override
  State<ChatbotManagementScreen> createState() => _ChatbotManagementScreenState();
}

class _ChatbotManagementScreenState extends State<ChatbotManagementScreen> {
  final List<_AssistantConfig> _assistants = [
    _AssistantConfig(
      name: 'BrainBox Social',
      description: 'Delivers multi-platform social captions.',
      isActive: true,
      color: const Color(0xFF6366F1),
      icon: Icons.auto_fix_high_rounded,
    ),
    _AssistantConfig(
      name: 'Podcast Producer',
      description: 'Generates show notes and highlight reels.',
      isActive: false,
      color: const Color(0xFFF97316),
      icon: Icons.podcasts,
    ),
    _AssistantConfig(
      name: 'Health Coach',
      description: 'Tracks wellness goals and reminders.',
      isActive: true,
      color: const Color(0xFF34D399),
      icon: Icons.favorite_border,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          children: [
            AppPageHeader(
              title: 'Manage assistants',
              subtitle: Text(
                'Toggle availability, adjust guardrails and update instructions.',
                style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 12),
            ..._assistants.map((assistant) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _AssistantTile(
                  config: assistant,
                  onToggle: (value) => setState(() => assistant.isActive = value),
                ),
              );
            }),
            const SizedBox(height: 12),
            AppButton(
              label: 'Create new assistant',
              leading: const Icon(Icons.add_rounded, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _AssistantConfig {
  _AssistantConfig({
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    this.isActive = true,
  });

  final String name;
  final String description;
  final Color color;
  final IconData icon;
  bool isActive;
}

class _AssistantTile extends StatelessWidget {
  const _AssistantTile({required this.config, required this.onToggle});

  final _AssistantConfig config;
  final ValueChanged<bool> onToggle;

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
            blurRadius: 28,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: config.color.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(config.icon, color: config.color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      config.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      config.description,
                      style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
              Switch(
                value: config.isActive,
                onChanged: onToggle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionPill(
                icon: Icons.edit_outlined,
                label: 'Edit prompt',
                onTap: () {},
              ),
              _ActionPill(
                icon: Icons.auto_mode_outlined,
                label: 'Automation',
                onTap: () {},
              ),
              _ActionPill(
                icon: Icons.share_outlined,
                label: 'Share',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surfaceMuted,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

