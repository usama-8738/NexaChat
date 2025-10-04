import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
          children: [
            AppPageHeader(
              title: 'Support',
              subtitle: Text(
                'Reach our team any time or browse tutorials to self-serve.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: 12),
            _SupportCard(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Live chat',
              description: 'Get help from specialists within minutes.',
              actionLabel: 'Start chat',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _SupportCard(
              icon: Icons.library_books_outlined,
              title: 'Knowledge base',
              description: 'Guides and how-to articles across all features.',
              actionLabel: 'Browse docs',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _SupportCard(
              icon: Icons.mail_outline,
              title: 'Email support',
              description: 'Contact support@nexachat.ai for in-depth queries.',
              actionLabel: 'Compose email',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportCard extends StatelessWidget {
  const _SupportCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: AppColors.textPrimary, size: 26),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AppButton(
            label: actionLabel,
            variant: AppButtonVariant.secondary,
            expand: false,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

