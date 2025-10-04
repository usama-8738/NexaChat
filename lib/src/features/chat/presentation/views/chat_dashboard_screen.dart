import 'package:flutter/material.dart';

import '../../../../app/router/routes.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class ChatDashboardScreen extends StatefulWidget {
  const ChatDashboardScreen({super.key});

  @override
  State<ChatDashboardScreen> createState() => _ChatDashboardScreenState();
}

class _ChatDashboardScreenState extends State<ChatDashboardScreen> {
  final List<String> _filters = const ['All', 'Pinned', 'Automations'];
  int _selectedFilter = 0;

  final List<_ChatSummary> _chats = const [
    _ChatSummary(
      title: 'BrainBox Social',
      subtitle: 'Campaign launch ideas · Updated 12m ago',
      badge: 'Active',
      icon: Icons.auto_awesome,
      color: Color(0xFF6366F1),
    ),
    _ChatSummary(
      title: 'Health Companion',
      subtitle: 'Lifestyle coaching prompts · Updated 43m ago',
      badge: 'Scheduled',
      icon: Icons.self_improvement_outlined,
      color: Color(0xFF34D399),
    ),
    _ChatSummary(
      title: 'Investor Brief',
      subtitle: 'Weekly digest · Updated yesterday',
      badge: 'Archived',
      icon: Icons.trending_up_rounded,
      color: Color(0xFFFB923C),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppPageHeader(
                title: 'BrainBox Cockpit',
                subtitle: Text(
                  'Monitor assistant performance and jump back into conversations.',
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
                actions: [
                  AppIconButton(
                    icon: const Icon(Icons.history_rounded),
                    onPressed: () => Navigator.of(context).pushNamed(AppRoutes.history),
                    isTonal: true,
                  ),
                  const SizedBox(width: 12),
                  AppIconButton(
                    icon: const Icon(Icons.more_horiz_rounded),
                    onPressed: () {},
                    isTonal: true,
                  ),
                ],
                showBack: false,
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final selected = index == _selectedFilter;
                    return ChoiceChip(
                      label: Text(_filters[index]),
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedFilter = index),
                      showCheckmark: false,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 120),
                  itemBuilder: (context, index) {
                    final chat = _chats[index];
                    return _ChatCard(chat: chat);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: _chats.length,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AppButton(
          label: 'Start new chat',
          leading: const Icon(Icons.add_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pushNamed(AppRoutes.chatRoom),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _ChatSummary {
  const _ChatSummary({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String badge;
  final IconData icon;
  final Color color;
}

class _ChatCard extends StatelessWidget {
  const _ChatCard({required this.chat});

  final _ChatSummary chat;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.chatRoom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x080F172A),
              offset: Offset(0, 18),
              blurRadius: 35,
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
                    color: chat.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(chat.icon, color: chat.color, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.title,
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        chat.subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    chat.badge,
                    style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                AppButton(
                  label: 'Continue',
                  variant: AppButtonVariant.primary,
                  expand: false,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.chatRoom),
                ),
                const SizedBox(width: 12),
                AppButton(
                  label: 'Share',
                  variant: AppButtonVariant.secondary,
                  expand: false,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

