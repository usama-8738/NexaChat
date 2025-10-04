import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = const [
      _HistoryEntry(
        title: 'Summarise product roadmap',
        assistant: 'BrainBox Social',
        updated: '2 hours ago',
        icon: Icons.auto_awesome,
        color: Color(0xFF6366F1),
      ),
      _HistoryEntry(
        title: 'Create 3 TikTok scripts',
        assistant: 'Growth Mentor',
        updated: 'Yesterday',
        icon: Icons.movie_creation_outlined,
        color: Color(0xFFF97316),
      ),
      _HistoryEntry(
        title: 'Weekly health recap',
        assistant: 'Health Coach',
        updated: '3 days ago',
        icon: Icons.favorite_border,
        color: Color(0xFF34D399),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Column(
            children: [
              AppPageHeader(
                title: 'History',
                subtitle: Text(
                  'Revisit conversations, pin favourites and share transcripts.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.textSecondary),
                ),
                actions: [
                  AppIconButton(
                    icon: const Icon(Icons.filter_list_rounded),
                    onPressed: () {},
                    isTonal: true,
                  ),
                  const SizedBox(width: 12),
                  AppIconButton(
                    icon: const Icon(Icons.search_rounded),
                    onPressed: () {},
                    isTonal: true,
                  ),
                ],
                showBack: false,
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 120),
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return _HistoryCard(entry: entry);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemCount: entries.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryEntry {
  const _HistoryEntry({
    required this.title,
    required this.assistant,
    required this.updated,
    required this.icon,
    required this.color,
  });

  final String title;
  final String assistant;
  final String updated;
  final IconData icon;
  final Color color;
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry});

  final _HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(entry.title),
      background: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFDAD7),
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: const Icon(Icons.delete_outline, color: Colors.black87),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(28),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: const Icon(Icons.push_pin_outlined, color: Colors.black87),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
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
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(entry.icon, color: entry.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${entry.assistant} · ${entry.updated}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                AppIconButton(
                  icon: const Icon(Icons.more_horiz_rounded),
                  onPressed: () {},
                  isTonal: true,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '“Capture three headline options for the product drop and summarise the differentiators in 80 words.”',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AppButton(
                  label: 'Open chat',
                  variant: AppButtonVariant.secondary,
                  expand: false,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                AppButton(
                  label: 'Export',
                  variant: AppButtonVariant.secondary,
                  expand: false,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

